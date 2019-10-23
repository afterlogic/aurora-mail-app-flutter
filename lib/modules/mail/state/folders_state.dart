import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/utils/constants.dart';
import 'package:mobx/mobx.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'folders_state.g.dart';

class FoldersState = _FoldersState with _$FoldersState;

abstract class _FoldersState with Store {
  final _foldersApi = new FoldersApi();
  final _foldersDao = new FoldersDao(AppStore.appDb);
  final _mailApi = new MailApi();
  final _mailDao = new MailDao(AppStore.appDb);
  final _authState = AppStore.authState;

  List<Folder> currentFolders = new List();

  @observable
  LoadingType isFoldersLoading = LoadingType.none;

  @observable
  Folder selectedFolder;

  @observable
  LoadingType isMessagesLoading = LoadingType.none;

  final List<Folder> syncFoldersQueue = new List();

  // 1) get folders
  // 2) set selected folder
  // 3) check if they didn't change
  // 4) get new info for changed folders
  // 5) get new messages/removed old

  Future<void> onGetFolders(Folder chosenFolder,
      {Function(String) onError,
      LoadingType loading = LoadingType.visible}) async {
    try {
      final accountId = AppStore.authState.accountId;

      // if chosenFolder is not null, that means the folder were already loaded
      // and user has just selected another folder
      if (chosenFolder == null) {
        isFoldersLoading = loading;
        List<LocalFolder> localFolders =
            await _foldersDao.getAllFolders(accountId);

        // if no folders or if refreshed
        if (localFolders == null ||
            localFolders.isEmpty ||
            loading == LoadingType.refresh) {
          final rawFolders = await _foldersApi.getFolders(accountId);

          final newFolders =
              await Folders.getFolderObjectsFromServerAsync(rawFolders);
          await _foldersDao.deleteFolders();
          await _foldersDao.addFolders(newFolders);

          localFolders = await _foldersDao.getAllFolders(accountId);
          currentFolders = Folder.getFolderObjectsFromDb(localFolders);

          // if this is the first time user launches the app, download mail from specified folders
          if (loading != LoadingType.refresh) {
            syncFoldersQueue.add(currentFolders[0]);
            syncFoldersQueue.add(currentFolders[1]);
            syncFoldersQueue.add(currentFolders[2]);
          }
        } else {
          // else update old folders
          currentFolders = Folder.getFolderObjectsFromDb(localFolders);
          await _updateFoldersHash();
        }

        selectedFolder = currentFolders[0];
        isFoldersLoading = LoadingType.none;
      } else {
        // to avoid rebuilding on initState
        await Future.delayed(Duration(milliseconds: 10));
        selectedFolder = chosenFolder;
      }
      if (selectedFolder.messagesInfo == null) {
        syncFoldersQueue.add(selectedFolder);
      }
      await _setMessagesInfoToFolder(onError: onError);
      _watchFolders(accountId);
    } catch (err, s) {
      print("onGetFolders err: $err");
      print("onGetFolders s: $s");
      onError(err.toString());
      isFoldersLoading = LoadingType.none;
    }
  }

  Future<void> _setMessagesInfoToFolder({Function(String) onError}) async {
    if (syncFoldersQueue.isEmpty) {
      print("no folders to sync");
      return;
    }
    final folder = syncFoldersQueue[0];
    print("syncing messages for: ${folder.fullNameRaw}");

    isMessagesLoading =
        folder.messagesInfo == null ? LoadingType.hidden : LoadingType.visible;
    try {
      String rawInfo = await _mailApi.getMessagesInfo(
        folderName: folder.fullNameRaw,
        accountId: _authState.accountId,
      );

      if (folder.messagesInfo != null) {
        rawInfo = _calculateDiff(folder.messagesInfo, rawInfo);
      }

      await _foldersDao.setMessagesInfo(folder.fullNameRaw, rawInfo);

      _syncMessagesChunk(folder);
    } catch (err, s) {
      print("onSetMessagesInfoToFolder: err: ${err}");
      print("onSetMessagesInfoToFolder: s: ${s}");
      onError(err.toString());
      isMessagesLoading = LoadingType.none;
    }
  }

  Future _watchFolders(int accountId) async {
    await for (final newFolders in _foldersDao.watchAllFolders(accountId)) {
      currentFolders = Folder.getFolderObjectsFromDb(newFolders);
      if (selectedFolder == null) selectedFolder = currentFolders[0];
    }
  }

  Future<void> _updateFoldersHash() async {
    // TODO VO: find out how many folders are needed to update hash
    final accountId = AppStore.authState.accountId;
    final folders = await _foldersApi.getRelevantFoldersInformation(
        accountId, currentFolders);

    final futures = new List<Future>();

    folders.keys.forEach((fName) {
      final updatedFolder = folders[fName];
      final folder = currentFolders.firstWhere((f) => f.fullNameRaw == fName);

      futures.add(_foldersDao.updateFolder(
        new FoldersCompanion(
          count: Value(updatedFolder[0]),
          unread: Value(updatedFolder[1]),
          fullNameHash: Value(updatedFolder[3]),
        ),
        folder.localId,
      ));

      if (folder.fullNameHash != updatedFolder[3] &&
          !syncFoldersQueue.contains(folder)) {
        print("folder added into queue: ${folder.fullNameRaw}");
        syncFoldersQueue.add(folder);
      }
    });

    await Future.wait(futures);
  }

  Future<void> _syncMessagesChunk(Folder selectedFolder) async {
    if (selectedFolder.fullNameRaw != syncFoldersQueue[0].fullNameRaw) {
      print("another folder was selected");
      _setMessagesInfoToFolder();
      return;
    }

    try {
      final folderName = selectedFolder.fullNameRaw;

      final folder = await _foldersDao.getFolder(selectedFolder.localId);

      final String infoInJson = folder[0].messagesInfoInJson;

      final uidsAndUpdateInfo = _takeChunk(infoInJson);
      final uids = uidsAndUpdateInfo["uids"];
      final updatedInfo = uidsAndUpdateInfo["updatedInfo"];

      final rawBodies = await _mailApi.getMessageBodies(
          folderName: folderName, accountId: _authState.accountId, uids: uids);

      final messages = Mail.getMessageObjFromServer(rawBodies, updatedInfo);

      _mailDao.addMessages(messages);

      final String encodedInfo = json.encode(updatedInfo);

      await _foldersDao.setMessagesInfo(folderName, encodedInfo);

      isMessagesLoading = LoadingType.visible;
      _syncMessagesChunk(selectedFolder);
    } catch (err, s) {
      syncFoldersQueue.removeAt(0);
      _setMessagesInfoToFolder();
      isMessagesLoading = LoadingType.none;
    }
  }

  // returns list of uids to load
  Map<String, List> _takeChunk(String encodedInfo) {
    final uids = new List<int>();
    final List info = json.decode(encodedInfo);
    int iteration = 0;

    void updateInfoObjAndGetUid(List messagesInfo, [int parentUid]) {
      for (final info in messagesInfo) {
        if (iteration < MESSAGES_PER_CHUNK) {
          if (info["hasBody"] != true) {
            info["hasBody"] = true;
            info["parentUid"] = parentUid;
            uids.add(info["uid"]);
            iteration++;
          }

          if (info["thread"] is List) {
            updateInfoObjAndGetUid(info["thread"], info["uid"]);
          }
        }
      }
    }

    updateInfoObjAndGetUid(info);
    assert(iteration <= MESSAGES_PER_CHUNK);

    return {
      "uids": uids,
      "updatedInfo": info,
    };
  }

  String _calculateDiff(List oldInfo, String newRawInfo) {
    // TODO VO calculate diff for threads as well
    final List newInfo = json.decode(newRawInfo);
    int addedUids = 0;
    final removedUids = new List<int>();
    final updatedInfo = new List();

    int i = 0;
    int j = 0;

    while (i < oldInfo.length || j < newInfo.length) {
      if (i >= oldInfo.length) {
        for (; j < newInfo.length; j++) {
          updatedInfo.add(newInfo[j]);
          addedUids++;
        }
        break;
      }
      if (j >= newInfo.length) {
        for (; i < oldInfo.length; i++) {
          removedUids.add(oldInfo[i]["uid"]);
        }
        break;
      }

      if (oldInfo[i]["uid"] == newInfo[j]["uid"]) {
        updatedInfo.add(oldInfo[i]);
        i++;
        j++;
      } else if (j < (newInfo.length - 1) &&
          oldInfo[i]["uid"] == newInfo[j + 1]["uid"]) {
        addedUids++;
        updatedInfo.add(newInfo[j]);
        j++;
      } else {
        removedUids.add(oldInfo[i]["uid"]);
        i++;
      }
    }

    if (removedUids.isNotEmpty) _mailDao.deleteMessages(removedUids);

    print(
        "Diff calculdation finished:\nAdded: $addedUids\nRemoved: ${removedUids.length}");

    return json.encode(updatedInfo);
  }
}
