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

  Duration filesSyncPeriod = Duration(seconds: 30);

  @observable
  LoadingType foldersLoading = LoadingType.none;

  @observable
  Folder selectedFolder;

  @observable
  LoadingType messagesLoading = LoadingType.none;

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
      foldersLoading = loading;
      List<LocalFolder> localFolders =
          await _foldersDao.getAllFolders(accountId);

      if (localFolders != null && localFolders.isNotEmpty) {
        currentFolders = Folder.getFolderObjectsFromDb(localFolders);
        updateFoldersHash(forceCurrentFolderUpdate: true);
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
        await _updateMessagesCount(accountId);
        foldersLoading = LoadingType.none;
        _checkWhichFolderNeedsUpdateNow();
      }

      // ================= STEP 2 =================
      selectedFolder = currentFolders[0];
      _watchFolders(accountId);
    } catch (err, s) {
      print("onGetFolders err: $err");
      print("onGetFolders s: $s");
      if (onError != null) onError(err.toString());
      foldersLoading = LoadingType.none;
    }
  }

  // used in drawer
  void selectFolder(Folder folder) {
    selectedFolder = folder;
    // TODO VO: make sure syncing isn't started during loading
    _checkWhichFolderNeedsUpdateNow();
  }

  // step 1a
  // used to refresh messages list
  Future<void> updateFoldersHash(
      {List<Folder> foldersToRefresh, forceCurrentFolderUpdate = false}) async {
    final accountId = AppStore.authState.accountId;
    try {
//      foldersLoading = LoadingType.visible;

      final folders = await _foldersApi.getRelevantFoldersInformation(
          accountId, foldersToRefresh ?? currentFolders);

      folders.keys.forEach((fName) {
        final updatedFolder = folders[fName];
        final folder = currentFolders.firstWhere((f) => f.fullNameRaw == fName);

        // only current folder can be force updated
        // the value cannot be set from true to false
        // because non-system folders update only when they are entered
        // thus might not have been synced yet
        final shouldUpdate = forceCurrentFolderUpdate == true &&
                folder.fullName == selectedFolder.fullName ||
            folder.needsInfoUpdate;

        final count = updatedFolder[0];
        final unread = updatedFolder[1];
        final newHash = updatedFolder[3];
        final needsInfoUpdate = folder.fullNameHash != newHash || shouldUpdate;

        folder.count = count;
        folder.unread = unread;
        folder.needsInfoUpdate = needsInfoUpdate;
        folder.fullNameHash = newHash;

        if (folder.localId == selectedFolder.localId) {
          selectedFolder.count = count;
          selectedFolder.unread = unread;
          selectedFolder.needsInfoUpdate =
              selectedFolder.fullNameHash != newHash ||
                  forceCurrentFolderUpdate;
          selectedFolder.fullNameHash = newHash;
        }
        currentFolders = currentFolders;

        _foldersDao.updateFolder(
          new FoldersCompanion(
            count: Value(count),
            unread: Value(unread),
            fullNameHash: Value(newHash),
            needsInfoUpdate: Value(needsInfoUpdate),
          ),
          folder.localId,
        );
      });
      // ================= STEP 3 =================
//      foldersLoading = LoadingType.none;
      await _checkWhichFolderNeedsUpdateNow();
    } catch (err, s) {
      print("updateFoldersHash err: ${err}");
      print("updateFoldersHash stack: ${s}");
//      foldersLoading = LoadingType.none;
      onError(err.toString());
    }
  }

  // step 3
  Future<void> _checkWhichFolderNeedsUpdateNow() async {
    // selectedFolder is of the highest priority
    if (selectedFolder.needsInfoUpdate) {
      // ================= STEP 4 =================
      await _setMessagesInfoToFolder(selectedFolder);
    } else {
      for (final folder in currentFolders) {
        if (folder.isSystemFolder && folder.needsInfoUpdate) {
          // ================= STEP 4 =================
          await _setMessagesInfoToFolder(folder);
          break;
        }
      }
    }
  }

  // step 4
  Future<void> _setMessagesInfoToFolder(Folder folder) async {
    print("getting folder info for: ${folder.fullNameRaw}");
    // interrupt syncing if another folder was selected and go to step 3
    if (selectedFolder.needsInfoUpdate &&
        selectedFolder.fullNameRaw != folder.fullNameRaw) {
      print("selected folder needs update");
      _checkWhichFolderNeedsUpdateNow();
      return;
    }

    messagesLoading = LoadingType.visible;
    try {
      final rawInfo = await _mailApi.getMessagesInfo(
        folderName: folder.fullNameRaw,
        accountId: _authState.accountId,
      );

      List<MessageInfo> messagesInfo = await Future.microtask(
          () => MessageInfo.flattenMessagesInfo(rawInfo));

      if (folder.messagesInfo != null) {
        messagesInfo = await _calculateDiff(folder.messagesInfo, messagesInfo);
      }

      folder.messagesInfo = messagesInfo;
      await _foldersDao.setMessagesInfo(folder.localId, messagesInfo);

      // ================= STEP 5 =================
      messagesLoading = LoadingType.none;
      await _syncMessagesChunk(folder);
    } catch (err, s) {
      print("onSetMessagesInfoToFolder: err: ${err}");
      print("onSetMessagesInfoToFolder: s: ${s}");
      if (onError != null) onError(err.toString());
      messagesLoading = LoadingType.none;
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
    // to avoid making multiple instances this function in parallel
    if (messagesLoading != LoadingType.none) {
      print("queue is blocked");
      await Future.delayed(Duration(milliseconds: 500));
      _checkWhichFolderNeedsUpdateNow();
      return;
    }

    messagesLoading = LoadingType.visible;

    try {
      // get the actual folder state every time
      final folder =
          await _foldersDao.getFolder(folderToGetMessageBodies.localId);

      final uids =
          await Future.microtask(() => _takeChunk(folder.messagesInfo));

      // if all messages are synced
      if (uids.length == 0) {
        print("messages synced for: ${folderToGetMessageBodies.fullNameRaw}");
        await _foldersDao.updateFolder(
          new FoldersCompanion(
            needsInfoUpdate: Value(false),
          ),
          folderToGetMessageBodies.localId,
        );
        folderToGetMessageBodies.needsInfoUpdate = false;
        messagesLoading = LoadingType.none;
        _checkWhichFolderNeedsUpdateNow();
      } else {
        print("syncing messages for: ${folderToGetMessageBodies.fullNameRaw}");
        final rawBodies = await _mailApi.getMessageBodies(
            folderName: folderToGetMessageBodies.fullNameRaw,
            accountId: _authState.accountId,
            uids: uids);

        final messages = Mail.getMessageObjFromServerAndUpdateInfoHasBody(
            rawBodies, folderToGetMessageBodies.messagesInfo);

        await _mailDao.addMessages(messages);

        await _foldersDao.setMessagesInfo(folderToGetMessageBodies.localId,
            folderToGetMessageBodies.messagesInfo);

        messagesLoading = LoadingType.none;
        // check if there are other messages to sync
        _syncMessagesChunk(folderToGetMessageBodies);
      }
    } catch (err, s) {
      print("_syncMessagesChunk err: ${err}");
      print("_syncMessagesChunk stack: ${s}");
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

  Future<void> _updateMessagesCount(int accountId) async {
    final folders = await _foldersApi.getRelevantFoldersInformation(
        accountId, currentFolders);

    folders.keys.forEach((fName) {
      final updatedFolder = folders[fName];
      final folder = currentFolders.firstWhere((f) => f.fullNameRaw == fName);

      folder.count = updatedFolder[0];
      folder.unread = updatedFolder[1];
      _foldersDao.updateFolder(
        new FoldersCompanion(
          count: Value(updatedFolder[0]),
          unread: Value(updatedFolder[1]),
        ),
        folder.localId,
      );
    });
  }

  Future _watchFolders(int accountId) async {
    await for (final newFolders in _foldersDao.watchAllFolders(accountId)) {
      currentFolders = Folder.getFolderObjectsFromDb(newFolders);
      if (selectedFolder == null) selectedFolder = currentFolders[0];
    }
  }

  // you cannot just return newInfo
  // you have to return oldInfo (because it contains hasBody: true) + addedMessages
  Future<List<MessageInfo>> _calculateDiff(
      List<MessageInfo> oldInfo, List<MessageInfo> newInfo) async {
    final unchangedMessages = oldInfo.where((i) =>
        newInfo.firstWhere((j) => j.uid == i.uid && j.parentUid == i.parentUid,
            orElse: () => null) !=
        null);

    // no need to calculate difference if all the messages are unchanged
    if (unchangedMessages.length == oldInfo.length &&
        unchangedMessages.length == newInfo.length) {
      print("Diff calcultaion finished: no changes");
      return oldInfo;
    }

    final addedMessages = newInfo.where((i) =>
        oldInfo.firstWhere((j) => j.uid == i.uid, orElse: () => null) == null);

    final removedMessages = oldInfo.where((i) =>
        newInfo.firstWhere((j) => j.uid == i.uid, orElse: () => null) == null);

    final changedParent = newInfo.where((i) =>
        oldInfo.firstWhere((j) => j.uid == i.uid && j.parentUid != i.parentUid,
            orElse: () => null) !=
        null);

    print("""
    Diff calcultaion finished:
      unchanged: ${unchangedMessages.length}
      changedParent: ${changedParent.length}
      removed: ${removedMessages.length}
      added: ${addedMessages.length}
    """);

    final removedUids = removedMessages.map((m) => m.uid).toList();
    final changedParentUid = changedParent.map((m) => m.uid).toList();

//    assert(removedUids.length == removedMessages.length);

    final List<MessageInfo> updatedInfo = [
      ...addedMessages,
      ...changedParent,
      ...unchangedMessages
    ];

    // delete removed messages
    if (removedUids.isNotEmpty || changedParentUid.isNotEmpty) {
      await _mailDao.deleteMessages([...removedUids, ...changedParentUid]);
    }

    return updatedInfo;
  }
}
