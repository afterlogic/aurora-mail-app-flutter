import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

class MailMethods {
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _mailDao = new MailDao(DBInstances.appDB);
  var needUpdateInfo = false;
  FoldersApi _foldersApi;
  MailApi _mailApi;

  final User user;
  final Account account;

  MailMethods({@required this.account, @required this.user}) {
    _foldersApi = new FoldersApi(user: user, account: account);
    _mailApi = new MailApi(user: user, account: account);
  }

  final _syncQueue = new List<String>();

  bool get _isOffline => SettingsBloc.isOffline;

  Future<List<Folder>> getFolders() async {
    // try to get from DB

    final folders = await _getOfflineFolders();

    if (folders != null && folders.isNotEmpty) {
      return folders;
    } else {
      // else get from server
      final rawFolders = await _foldersApi.getFolders();

      // first convert rawFolders to the format, which sql will accept and add to DB
      final newFolders = await Folders.getFolderObjectsFromServerAsync(
        rawFolders: rawFolders,
        accountId: account.accountId,
        accountLocalId: account.localId,
        userLocalId: user.localId,
      );
      await _foldersDao.addFolders(newFolders);

      final newFoldersWithIds =
          await _foldersDao.getAllFolders(account.localId);
      return Folder.getFolderObjectsFromDb(newFoldersWithIds);
    }
  }

  Future<List<Folder>> refreshFolders() async {
    if (_isOffline) return _getOfflineFolders();

    // fetch old folders
    final oldLocalFoldersFuture = _foldersDao.getAllFolders(account.localId);
    // fetch new folders
    final rawFoldersFuture = _foldersApi.getFolders();

    // run fetching ops in parallel
    final futureWaitResult = await Future.wait([
      rawFoldersFuture,
      oldLocalFoldersFuture,
    ]);

    // get result
    final rawFolders = futureWaitResult[0] as Map<String, dynamic>;
    final oldLocalFolders = futureWaitResult[1] as List<LocalFolder>;

    // convert new folders to db-like format (the format of old folders) for calculating difference
    final newLocalFolders = await Folders.getFolderObjectsFromServerAsync(
      rawFolders: rawFolders,
      accountId: account.accountId,
      accountLocalId: account.localId,
      userLocalId: user.localId,
    );

    // calculate difference
    final calcResult = await Folders.calculateFoldersDiffAsync(
        oldLocalFolders, newLocalFolders);

    final removedFolders = calcResult.deletedFolders;
    final addedFolders = calcResult.addedFolders;

    final dbFutures = new List<Future>();

    if (removedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.deleteFolders(removedFolders));

      // delete messages of removed folders
      final List<String> removedFoldersRawNames =
          removedFolders.map((f) => f.fullNameRaw).toList();
      dbFutures.add(
          _mailDao.deleteMessagesFromRemovedFolders(removedFoldersRawNames));
    }
    if (addedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.addFolders(addedFolders));
    }

    // if dbFutures IS empty, then no changes were detected
    if (dbFutures.isNotEmpty) {
      await Future.wait(dbFutures);

      final newFoldersWithIds =
          await _foldersDao.getAllFolders(account.localId);
      return Folder.getFolderObjectsFromDb(newFoldersWithIds);
    } else {
      return Folder.getFolderObjectsFromDb(oldLocalFolders);
    }
  }

  Future<List<Folder>> updateFoldersHash(Folder selectedFolder,
      {bool forceCurrentFolderUpdate = false}) async {
    if (_isOffline) return _getOfflineFolders();

    assert(selectedFolder != null);

    final localFolders = await _foldersDao.getAllFolders(account.localId);

    final folders =
        await _foldersApi.getRelevantFoldersInformation(localFolders);

    final futures = new List<Future>();

    folders.keys.forEach((fName) {
      final updatedFolder = folders[fName];
      final folder = localFolders.firstWhere((f) => f.fullNameRaw == fName);

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

      futures.add(_foldersDao.updateFolder(
        new FoldersCompanion(
          count: Value(count as int),
          unread: Value(unread as int),
          fullNameHash: Value(newHash as String),
          needsInfoUpdate: Value(needsInfoUpdate),
        ),
        folder.guid,
      ));
    });

    await Future.wait(futures);
    final updatedLocalFolders =
        await _foldersDao.getAllFolders(account.localId);
    return Folder.getFolderObjectsFromDb(updatedLocalFolders);
  }

  Future<void> syncFolders(
      {@required String guid, bool syncSystemFolders = false}) async {
    if (_isOffline || user == null) return null;

    // either localId or syncSystemFolders must be provided
    assert(guid != null || syncSystemFolders != null);
    var localFolders = new List<LocalFolder>();
    if (syncSystemFolders == true) {
      localFolders = await _foldersDao.getAllFolders(account.localId);
      localFolders.sort((a, b) => a.folderOrder.compareTo(b.folderOrder));
    }

    final queueLengthBeforeInsert = _syncQueue.length;

    localFolders.forEach((f) {
      if (f.isSystemFolder && !_syncQueue.contains(f.guid)) {
        _syncQueue.add(f.guid);
      }
    });

    if (guid != null) {
      if (_syncQueue.contains(guid)) _syncQueue.remove(guid);
      _syncQueue.insert(0, guid);
    }
    if (_syncQueue.isNotEmpty && queueLengthBeforeInsert == 0) {
      await _setMessagesInfoToFolder();
    } else if (_syncQueue.isNotEmpty) {
      needUpdateInfo = true;
    }
  }

  Future<void> _setMessagesInfoToFolder() async {
    if (_isOffline || user == null) return null;
    if (_syncQueue.isEmpty) {
      return;
    }

    final folderToUpdate = await _foldersDao.getFolderByLocalId(_syncQueue[0]);
    // get the actual sync period
    final updatedUser = await _usersDao.getUserByLocalId(user.localId);

    if (folderToUpdate.needsInfoUpdate == false) {
      _syncQueue.remove(folderToUpdate.guid);
      if (_syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    }

    print("getting folder info for: ${folderToUpdate.fullNameRaw}");

    final syncPeriod = SyncPeriod.dbStringToPeriod(updatedUser.syncPeriod);
    final periodStr = SyncPeriod.periodToDate(syncPeriod);
    final rawInfo = await _mailApi.getMessagesInfo(
        folderName: folderToUpdate.fullNameRaw, search: "date:$periodStr/");

    List<MessageInfo> newMessagesInfo =
        MessageInfo.flattenMessagesInfo(rawInfo);

    // calculate difference
    final oldMessagesInfo = await FolderMessageInfo.getMessageInfo(
      folderToUpdate.fullName,
      account.localId,
    );

    if (oldMessagesInfo != null) {
      final calcResult = await Folders.calculateMessagesInfoDiffAsync(
        oldMessagesInfo,
        newMessagesInfo,
      );

      newMessagesInfo = calcResult.updatedInfo;
      await _mailDao.deleteMessages(
          calcResult.removedUids, folderToUpdate.fullNameRaw);
      await _mailDao.updateMessagesFlags(calcResult.infosToUpdateFlags);
    }

    await FolderMessageInfo.setMessageInfo(
      folderToUpdate.fullName,
      account.localId,
      newMessagesInfo,
    );

    await _syncMessagesChunk(SyncPeriod.periodToDbString(syncPeriod));
    await _foldersDao.updateFolder(
      FoldersCompanion(needsInfoUpdate: Value(false)),
      folderToUpdate.guid,
    );
  }

  // step 5
  Future<void> _syncMessagesChunk(String syncPeriod) async {
    if (_isOffline || user == null) return null;
    assert(_syncQueue.isNotEmpty);

    // get the actual folder state every time
    final folder = await _foldersDao.getFolderByLocalId(_syncQueue[0]);
    // get the actual sync period
    final updatedUser = await _usersDao.getUserByLocalId(user.localId);
//    if (folder?.messagesInfo == null) {
//      print(
//          "Attention! messagesInfo is null, perhaps another folder was selected while messages info was being retrieved.");
//      return _setMessagesInfoToFolder();
//    }

    if (updatedUser.syncPeriod != syncPeriod) {
      print(
          "Attention! another sync period was selected, refetching messages info...");
      return _setMessagesInfoToFolder();
    }
    if (needUpdateInfo == true) {
      needUpdateInfo = false;
      return _setMessagesInfoToFolder();
    }

    var messageInfo = await FolderMessageInfo.getMessageInfo(
      folder.fullName,
      account.localId,
    );
    if (messageInfo == null) {
      print(
          "Attention! messagesInfo is null, perhaps another folder was selected while messages info was being retrieved.");
      return _setMessagesInfoToFolder();
    }
    // TODO make async
    final uids = _takeChunk(messageInfo);

    // if all messages are synced
    if (uids.length == 0) {
      print("All the messages have been synced for: ${folder.fullNameRaw}");
      await _foldersDao.updateFolder(
        new FoldersCompanion(
          needsInfoUpdate: Value(false),
        ),
        folder.guid,
      );
      assert(_syncQueue.contains(folder.guid));
      _syncQueue.remove(folder.guid);
      print("_syncQueue: $_syncQueue");
      if (_syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    } else {
      print("syncing messages for: ${folder.fullNameRaw}");
      final rawBodies = await _mailApi.getMessageBodies(
        folderName: folder.fullNameRaw,
        uids: uids,
      );
      // TODO make async
      final messages = Mail.getMessageObjFromServerAndUpdateInfoHasBody(
        rawBodies,
        messageInfo,
        updatedUser.localId,
        account,
        folder,
      );

      await _mailDao.addMessages(messages);

      await FolderMessageInfo.setMessageInfo(
        folder.fullName,
        account.localId,
        messageInfo,
      );

      // check if there are other messages to sync
      return _syncMessagesChunk(syncPeriod);
    }
  }

  // returns list of uids to load
  List<int> _takeChunk(List<MessageInfo> messagesInfo) {
    final uids = new List<int>();
    int iteration = 0;
    int offset = 0;
    messagesInfo.forEach((info) {
      if (iteration < MESSAGES_PER_CHUNK) {
        if (info.hasBody != true) {
          uids.add(info.uid);
          iteration++;
        } else {
          offset++;
        }
      }
    });
    print("uids offset $offset/${messagesInfo.length}");
    assert(iteration <= MESSAGES_PER_CHUNK);

    return uids;
  }

  Future<void> setMessagesSeen({
    @required Folder folder,
    @required List<Message> messages,
    @required bool isSeen,
  }) async {
    if (_isOffline) return null;

    Future updateMessages(bool isStarred) async {
      final infos = messages.map((m) {
        final flags = json.decode(m.flagsInJson) as List;

        if (isStarred && !flags.contains("\\seen")) {
          flags.add("\\seen");
        } else if (!isStarred && flags.contains("\\seen")) {
          flags.remove("\\seen");
        }

        return new MessageInfo(
          uid: m.uid,
          parentUid: m.parentUid,
          flags: new List<String>.from(flags),
          hasBody: true,
          hasThread: m.hasThread,
        );
      }).toList();
      _mailDao.updateMessagesFlags(infos);
    }

    try {
      updateMessages(isSeen);
      await _mailApi.setMessagesSeen(
        folder: folder,
        uids: messages.map((m) => m.uid).toList(),
      );
    } catch (err) {
      updateMessages(!isSeen);
    }
  }

  Future<void> setMessagesStarred({
    @required Folder folder,
    @required List<Message> messages,
    @required bool isStarred,
  }) async {
    if (_isOffline) return null;

    void updateMessages(bool isStarred) {
      final infos = messages.map((m) {
        final flags = json.decode(m.flagsInJson) as List;

        if (isStarred && !flags.contains("\\flagged")) {
          flags.add("\\flagged");
        } else if (!isStarred && flags.contains("\\flagged")) {
          flags.remove("\\flagged");
        }

        return new MessageInfo(
          uid: m.uid,
          parentUid: m.parentUid,
          flags: new List<String>.from(flags),
          hasBody: true,
          hasThread: m.hasThread,
        );
      }).toList();
      _mailDao.updateMessagesFlags(infos);
    }

    try {
      updateMessages(isStarred);
      await _mailApi.setMessagesFlagged(
        folder: folder,
        uids: messages.map((m) => m.uid).toList(),
        isStarred: isStarred,
      );
    } catch (err) {
      updateMessages(!isStarred);
    }
  }

  Future<List<Folder>> _getOfflineFolders() async {
    final List<LocalFolder> localFolders =
        await _foldersDao.getAllFolders(account.localId);
    return Folder.getFolderObjectsFromDb(localFolders);
  }

  Future<void> setEmailSafety(String senderEmail) async {
    await _mailApi.setEmailSafety(senderEmail: senderEmail);
  }

  Future<Message> getMessage(Message item) {
    return _mailDao.getMessage(item.localId);
  }

  Future<Folder> getFolder(String guid) {
    return _foldersDao.getFolderByLocalId(guid);
  }
}
