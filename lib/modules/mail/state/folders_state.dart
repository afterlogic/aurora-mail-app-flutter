import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/loading_enum.dart';
import 'package:aurora_mail/models/message_info.dart';
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

  Function(String) onError;

  // ================= STEPS =================
  // 1a) get folders from sqlite and check if they didn't change
  // OR
  // 1b) get folders from server if it's the first app start or the folders are being refreshed
  // 2) set selected folder
  // 3) check which folder needs to be updated first
  // 4) get new info for this folder
  // 5) get new messages/removed old
  // if another folder was selected or all the messages were synced go to step 3)

  // step 1
  Future<void> getFolders({LoadingType loading = LoadingType.visible}) async {
    try {
      final accountId = AppStore.authState.accountId;

      // if chosenFolder is not null, that means the folder were already loaded
      // and user has just selected another folder, no need to load them again
      // // if chosenFolder IS null the app has just started

      // ================= STEP 1a =================
      isFoldersLoading = loading;
      List<LocalFolder> localFolders =
          await _foldersDao.getAllFolders(accountId);

      if (localFolders != null && localFolders.isNotEmpty
          // TODO VO: find out about refreshing
          /*&& loading != LoadingType.refresh*/) {
        currentFolders = Folder.getFolderObjectsFromDb(localFolders);
        _updateFoldersHash();
      } else {
        // ================= STEP 1b =================
        final rawFolders = await _foldersApi.getFolders(accountId);

        final newFolders =
            await Folders.getFolderObjectsFromServerAsync(rawFolders);
        await _foldersDao.deleteFolders();
        await _foldersDao.addFolders(newFolders);

        localFolders = await _foldersDao.getAllFolders(accountId);
        currentFolders = Folder.getFolderObjectsFromDb(localFolders);
        selectedFolder = currentFolders[0];
        // ================= STEP 3 =================
        _checkWhichFolderNeedsUpdateNow();
      }

      // ================= STEP 2 =================
      selectedFolder = currentFolders[0];
      isFoldersLoading = LoadingType.none;
      _watchFolders(accountId);
    } catch (err, s) {
      print("onGetFolders err: $err");
      print("onGetFolders s: $s");
      if (onError != null) onError(err.toString());
      isFoldersLoading = LoadingType.none;
    }
  }

  void selectFolder(Folder folder) {
    selectedFolder = folder;
    _checkWhichFolderNeedsUpdateNow();
  }

  // step 1a
  Future<void> _updateFoldersHash([List<Folder> foldersToRefresh]) async {
    final accountId = AppStore.authState.accountId;
    try {
      final folders = await _foldersApi.getRelevantFoldersInformation(
          accountId, foldersToRefresh ?? currentFolders);

      folders.keys.forEach((fName) {
        final updatedFolder = folders[fName];
        final folder = currentFolders.firstWhere((f) => f.fullNameRaw == fName);

        isFoldersLoading = LoadingType.hidden;
        folder.count = updatedFolder[0];
        folder.unread = updatedFolder[1];
        folder.fullNameHash = updatedFolder[3];
        folder.needsInfoUpdate = folder.fullNameHash != updatedFolder[3];
        if (folder.localId == selectedFolder.localId) {
          selectedFolder.count = updatedFolder[0];
          selectedFolder.unread = updatedFolder[1];
          selectedFolder.fullNameHash = updatedFolder[3];
          selectedFolder.needsInfoUpdate =
              selectedFolder.needsInfoUpdate != updatedFolder[3];
        }
        isFoldersLoading = LoadingType.none;

        _foldersDao.updateFolder(
          new FoldersCompanion(
            count: Value(updatedFolder[0]),
            unread: Value(updatedFolder[1]),
            fullNameHash: Value(updatedFolder[3]),
            needsInfoUpdate: Value(folder.fullNameHash != updatedFolder[3]),
          ),
          folder.localId,
        );
      });
      // ================= STEP 3 =================
      _checkWhichFolderNeedsUpdateNow();
    } catch (err, s) {
      print("VO: updateFoldersHash: ${err}");
      print("VO: updateFoldersHash: ${s}");
      onError(err.toString());
    }
  }

  // step 3
  void _checkWhichFolderNeedsUpdateNow() {
    // selectedFolder is of the highest priority
    if (selectedFolder.needsInfoUpdate) {
      // ================= STEP 4 =================
      setMessagesInfoToFolder(selectedFolder);
    } else {
      for (final folder in currentFolders) {
        if (folder.isSystemFolder && folder.needsInfoUpdate) {
          // ================= STEP 4 =================
          setMessagesInfoToFolder(folder);
          break;
        }
      }
    }
  }

  // step 4
  Future<void> setMessagesInfoToFolder(Folder folder) async {
    print("getting folder info for: ${folder.fullNameRaw}");

    isMessagesLoading =
        folder.messagesInfo == null ? LoadingType.hidden : LoadingType.visible;
    try {
      final rawInfo = await _mailApi.getMessagesInfo(
        folderName: folder.fullNameRaw,
        accountId: _authState.accountId,
      );

      List<MessageInfo> messagesInfo = MessageInfo.flattenMessagesInfo(rawInfo);

      if (folder.messagesInfo != null) {
        messagesInfo = _calculateDiff(folder.messagesInfo, messagesInfo);
      }

      folder.messagesInfo = messagesInfo;
      await _foldersDao.setMessagesInfo(folder.localId, messagesInfo);

      // ================= STEP 5 =================
      _syncMessagesChunk(folder);
    } catch (err, s) {
      print("onSetMessagesInfoToFolder: err: ${err}");
      print("onSetMessagesInfoToFolder: s: ${s}");
      if (onError != null) onError(err.toString());
      isMessagesLoading = LoadingType.none;
    }
  }

  // step 5
  Future<void> _syncMessagesChunk(Folder folderToGetMessageBodies) async {
    // interrupt syncing if another folder was selected and go to step 3
    if (selectedFolder.needsInfoUpdate &&
        selectedFolder.fullNameRaw != folderToGetMessageBodies.fullNameRaw) {
      print("selected folder needs update");
      _checkWhichFolderNeedsUpdateNow();
      return;
    }
    print("syncing messages for: ${folderToGetMessageBodies.fullNameRaw}");

    try {
      // get the actual folder state every time
      final folder =
          await _foldersDao.getFolder(folderToGetMessageBodies.localId);

      final uids = _takeChunk(folder.messagesInfo);

      // if all messages are synced
      if (uids.length == 0) {
        await _foldersDao.updateFolder(
          new FoldersCompanion(
            needsInfoUpdate: Value(false),
          ),
          folderToGetMessageBodies.localId,
        );
        folderToGetMessageBodies.needsInfoUpdate = false;
        _checkWhichFolderNeedsUpdateNow();
        isMessagesLoading = LoadingType.none;
      } else {
        final rawBodies = await _mailApi.getMessageBodies(
            folderName: folderToGetMessageBodies.fullNameRaw,
            accountId: _authState.accountId,
            uids: uids);

        final messages = Mail.getMessageObjFromServerAndUpdateInfoHasBody(
            rawBodies, folderToGetMessageBodies.messagesInfo);

        await _mailDao.addMessages(messages);

        await _foldersDao.setMessagesInfo(folderToGetMessageBodies.localId,
            folderToGetMessageBodies.messagesInfo);

        isMessagesLoading = LoadingType.visible;
        // check if there are other messages to sync
        _syncMessagesChunk(folderToGetMessageBodies);
      }
    } catch (err, s) {
      print("VO: _syncMessagesChunk: ${err}");
      print("VO: _syncMessagesChunk: ${s}");
    }
  }

  // returns list of uids to load
  List<int> _takeChunk(List<MessageInfo> messagesInfo) {
    final uids = new List<int>();
    int iteration = 0;

    messagesInfo.forEach((info) {
      if (iteration < MESSAGES_PER_CHUNK) {
        if (info.hasBody != true) {
          uids.add(info.uid);
          iteration++;
        }
      }
    });

    assert(iteration <= MESSAGES_PER_CHUNK);

    return uids;
  }

//
//  List _updateMessagesInfo(List oldInfo, List<Message> messagesFromServer) {
//    void updateInfo(List messagesInfo) {
//      for (final info in messagesInfo) {
//        try {
//          final downloadedMessage =
//              messagesFromServer.firstWhere((m) => m.uid == info["uid"]);
//          if (downloadedMessage != null) {
//            info["hasBody"] = true;
//          }
//        } catch (err) {}
//
//        if (info["thread"] is List) {
//          updateInfo(info["thread"]);
//        }
//      }
//    }
//
//    updateInfo(oldInfo);
//    return oldInfo;
//  }

  Future _watchFolders(int accountId) async {
    await for (final newFolders in _foldersDao.watchAllFolders(accountId)) {
      currentFolders = Folder.getFolderObjectsFromDb(newFolders);
      if (selectedFolder == null) selectedFolder = currentFolders[0];
    }
  }

  List<MessageInfo> _calculateDiff(
      List<MessageInfo> oldInfo, List<MessageInfo> newInfo) {
    // TODO repair
    int addedUids = 0;
    final removedUids = new List<int>();
    final updatedInfo = new List<MessageInfo>();

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
          removedUids.add(oldInfo[i].uid);
        }
        break;
      }

      if (oldInfo[i].uid == newInfo[j].uid) {
        updatedInfo.add(oldInfo[i]);
        i++;
        j++;
      } else if (j < (newInfo.length - 1) &&
          oldInfo[i].uid == newInfo[j + 1].uid) {
        addedUids++;
        updatedInfo.add(newInfo[j]);
        j++;
      } else {
        removedUids.add(oldInfo[i].uid);
        i++;
      }
    }

    // delete removed messages
    if (removedUids.isNotEmpty) _mailDao.deleteMessages(removedUids);

    print(
        "Diff calculdation finished:\nAdded: $addedUids\nRemoved: ${removedUids.length}");

    return updatedInfo;
  }
}
