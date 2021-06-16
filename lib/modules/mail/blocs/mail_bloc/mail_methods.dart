import 'dart:convert';
import 'dart:math';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

class MailMethods {
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _mailDao = new MailDao(DBInstances.appDB);
  final UpdateMessageCounter updateMessageCounter;
  var needUpdateInfo = false;
  FoldersApi _foldersApi;
  MailApi _mailApi;
  bool _closed = false;
  final User user;
  final Account account;

  MailMethods({
    @required this.account,
    @required this.user,
    this.updateMessageCounter,
  }) {
    _foldersApi = new FoldersApi(user: user, account: account);
    _mailApi = new MailApi(user: user, account: account);
  }

  static final syncQueue = new List<String>();

  bool get _isOffline => SettingsBloc.isOffline;

  Future<List<Folder>> getFolders() async {
    logger.log("method getFolders");
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
      return Folder.getFoldersObjectsFromDb(newFoldersWithIds);
    }
  }

  Future<List<Folder>> refreshFolders() async {
    logger.log("method refreshFolders");
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
    final updatedFolders = calcResult.updatedFolders;
    final dbFutures = new List<Future>();

    if (removedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.deleteFolders(removedFolders));

      // delete messages of removed folders
      final List<String> removedFoldersRawNames =
          removedFolders.map((f) => f.fullNameRaw).toList();
      dbFutures.add(
          _mailDao.deleteMessagesFromRemovedFolders(removedFoldersRawNames));
    }
    if (updatedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.updateFolders(updatedFolders));
    }

    if (addedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.addFolders(addedFolders));
    }

    // if dbFutures IS empty, then no changes were detected
    if (dbFutures.isNotEmpty) {
      await Future.wait(dbFutures);

      final newFoldersWithIds =
          await _foldersDao.getAllFolders(account.localId);
      return Folder.getFoldersObjectsFromDb(newFoldersWithIds);
    } else {
      return Folder.getFoldersObjectsFromDb(oldLocalFolders);
    }
  }

  Future<List<Folder>> updateFoldersHash(Folder selectedFolder,
      {bool forceCurrentFolderUpdate = false}) async {
    logger.log("method updateFoldersHash");
    if (_isOffline) return _getOfflineFolders();

    assert(selectedFolder != null);

    final localFolders = await _foldersDao.getAllFolders(account.localId);

    final folders = await _foldersApi.getRelevantFoldersInformation(
      localFolders.map((e) => e.fullNameRaw).toList(),
    );

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
      if (folder.fullNameHash != newHash) {
        logger.log("folder ${fName} have new hash");
      }
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
    return Folder.getFoldersObjectsFromDb(updatedLocalFolders);
  }

  Future updateFolderHash(Folder selectedFolder,
      {bool forceCurrentFolderUpdate = false}) async {
    logger.log("method updateFolderHash");
    if (_isOffline) return;

    assert(selectedFolder != null);
    var foldersForUpdate = await _foldersDao
        .getAllFolders(
          account.localId,
        )
        .then((value) => Folder.getFoldersObjectsFromDb(value));
    final foldersMap = {
      for (var item in foldersForUpdate) item.fullNameRaw: item,
      selectedFolder.fullNameRaw: selectedFolder,
    };
    final folders = await _foldersApi
        .getRelevantFoldersInformation(foldersMap.keys.toList());

    final futures = new List<Future>();
    if (folders.isEmpty) {
      return;
    }
    for (var value in folders.entries) {
      final fName = value.key;
      final updatedFolder = value.value;
      final folder = foldersMap[value.key];

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
      if (folder.fullNameHash != newHash) {
        logger.log("folder ${fName} have new hash");
      }
      futures.add(_foldersDao.updateFolder(
        new FoldersCompanion(
          count: Value(count as int),
          unread: Value(unread as int),
          fullNameHash: Value(newHash as String),
          needsInfoUpdate: Value(needsInfoUpdate),
        ),
        folder.guid,
      ));
    }
    await Future.wait(futures);
    final updatedLocalFolders =
        await _foldersDao.getAllFolders(account.localId);
    return Folder.getFoldersObjectsFromDb(updatedLocalFolders);
  }

  Future<void> syncFolders({
    @required String guid,
    bool syncSystemFolders = true,
    bool forceUpdateMessagesInfo = false,
  }) async {
    logger.log("method syncFolders");
    if (_isOffline || user == null) return null;

    // either localId or syncSystemFolders must be provided
    assert(guid != null || syncSystemFolders != null);
    var localFolders = new List<LocalFolder>();
    if (syncSystemFolders == true) {
      localFolders = await _foldersDao.getByType([
        Folder.getNumberFromFolderType(FolderType.inbox),
        Folder.getNumberFromFolderType(FolderType.sent),
        Folder.getNumberFromFolderType(FolderType.drafts)
      ], account.localId);
      localFolders.sort((a, b) => a.folderOrder.compareTo(b.folderOrder));
    }

    final queueLengthBeforeInsert = syncQueue.length;

    localFolders.forEach((f) {
      if (f.isSystemFolder && !syncQueue.contains(f.guid)) {
        syncQueue.add(f.guid);
      }
    });

    if (guid != null) {
      if (syncQueue.contains(guid)) syncQueue.remove(guid);
      syncQueue.insert(0, guid);
    }
    if (syncQueue.isNotEmpty && queueLengthBeforeInsert == 0) {
      try {
        await _setMessagesInfoToFolder(
          guid: guid,
          forceSync: forceUpdateMessagesInfo,
        );
      } catch (err, s) {
        logger.error(err, s);
        syncQueue.clear();
        rethrow;
      }
    } else if (syncQueue.isNotEmpty) {
      needUpdateInfo = true;
    }
  }

  Future<void> _setMessagesInfoToFolder({
    String guid,
    bool forceSync = false,
  }) async {
    logger.log(
        "method _setMessagesInfoToFolder(guid:$guid forceSync:$forceSync)");
    if (_isOffline || user == null) return null;
    if (syncQueue.isEmpty) {
      return;
    }

    final folderToUpdate = await _foldersDao.getFolderByGuId(syncQueue[0]);
    // get the actual sync period
    final updatedUser = await _usersDao.getUserByLocalId(user.localId);
    final forceUpdate = forceSync ? guid == folderToUpdate.guid : false;
    if (folderToUpdate.needsInfoUpdate == false && !forceUpdate) {
      syncQueue.remove(folderToUpdate.guid);
      if (syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    }

    logger.log("getting folder info for: ${folderToUpdate.fullNameRaw}");

    final syncPeriod = SyncPeriod.dbStringToPeriod(updatedUser.syncPeriod);
    final periodStr = SyncPeriod.periodToDate(syncPeriod);
    final rawInfo = await _mailApi.getMessagesInfo(
        folderName: folderToUpdate.fullNameRaw, search: "date:$periodStr/");

    List<MessageInfo> newMessagesInfo =
        MessageInfo.flattenMessagesInfo(rawInfo);

    // calculate difference
    final oldMessagesInfo = await FolderMessageInfo.getMessageInfo(
      folderToUpdate.fullNameRaw,
      account.localId,
    );

    if (oldMessagesInfo != null) {
      final calcResult = await Folders.calculateMessagesInfoDiffAsync(
        oldMessagesInfo,
        newMessagesInfo,
      );

      newMessagesInfo = calcResult.updatedInfo;
      logger.log("new messages: ${calcResult.addedMessages.length}");
      await _mailDao.deleteMessages(
          calcResult.removedUids, folderToUpdate.fullNameRaw);
      await _mailDao.updateMessagesFlags(calcResult.infosToUpdateFlags);

      await _mailDao.addEmptyMessages(
        calcResult.addedMessages,
        account,
        user,
        folderToUpdate.fullNameRaw,
      );
    } else {
      await _mailDao.addEmptyMessages(
        newMessagesInfo,
        account,
        user,
        folderToUpdate.fullNameRaw,
      );
    }
    await FolderMessageInfo.setMessageInfo(
      folderToUpdate.fullNameRaw,
      account.localId,
      newMessagesInfo,
    );

    if (newMessagesInfo == null) {
      logger.log(
          "Attention! messagesInfo is null, perhaps another folder was selected while messages info was being retrieved.");
      return _setMessagesInfoToFolder();
    }
    final messages = await _getMessageInfoWithNotBody(newMessagesInfo);
    currentFolderUpdate = folderToUpdate.fullNameRaw;

    await _syncMessagesChunk(
      SyncPeriod.periodToDbString(syncPeriod),
      messages,
      messages.length,
      folderToUpdate,
    );
    await _foldersDao.updateFolder(
      FoldersCompanion(needsInfoUpdate: Value(false)),
      folderToUpdate.guid,
    );
    currentFolderUpdate = null;
  }

  // step 5
  Future<void> _syncMessagesChunk(
    String syncPeriod,
    List<Message> messagesForUpdate,
    int folderMessageCount,
    Folder currentFolder,
  ) async {
    logger.log("method _syncMessagesChunk");
    updateMessageCounter.update(
      currentFolder,
      folderMessageCount,
      folderMessageCount - messagesForUpdate.length,
    );
    if (_closed || _isOffline || user == null) {
      updateMessageCounter.empty();
      return;
    }
    assert(syncQueue.isNotEmpty);

    // get the actual folder state every time
    final folder = await _foldersDao.getFolderByGuId(syncQueue[0]);
    // get the actual sync period
    final updatedUser = await _usersDao.getUserByLocalId(user.localId);
//    if (folder?.messagesInfo == null) {
//      print(
//          "Attention! messagesInfo is null, perhaps another folder was selected while messages info was being retrieved.");
//      return _setMessagesInfoToFolder();
//    }
    if (SyncPeriod.dbStringToPeriod(updatedUser.syncPeriod) !=
        SyncPeriod.dbStringToPeriod(syncPeriod)) {
      print(
          "Attention! another sync period was selected, refetching messages info...");
      updateMessageCounter.empty();
      return _setMessagesInfoToFolder();
    }
    if (needUpdateInfo == true) {
      needUpdateInfo = false;
      updateMessageCounter.empty();
      return _setMessagesInfoToFolder();
    }
    final uids = messagesForUpdate
        .getRange(0, min(MESSAGES_PER_CHUNK, messagesForUpdate.length))
        .toList();

    logger.log("${messagesForUpdate.length} messages in queue");
    // if all messages are synced
    if (uids.length == 0) {
      updateMessageCounter.empty();
      logger
          .log("All the messages have been synced for: ${folder.fullNameRaw}");
      await _foldersDao.updateFolder(
        new FoldersCompanion(
          needsInfoUpdate: Value(false),
        ),
        folder.guid,
      );
      assert(syncQueue.contains(folder.guid));
      syncQueue.remove(folder.guid);
      logger.log("_syncQueue: $syncQueue");
      if (syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    } else {
      logger.log("syncing messages for: ${folder.fullNameRaw}");
      final rawBodies = await _mailApi.getMessageBodies(
        folderName: folder.fullNameRaw,
        uids: uids.map((item) => item.uid).toList(),
      );
      // TODO make async
      final messages = await Mail.getMessageObjFromServerAndUpdateInfoHasBody(
        rawBodies,
        uids,
        updatedUser.localId,
        account,
      );
      await _mailDao.fillMessages(messages);
      // check if there are other messages to sync
      _syncMessagesChunk(
        syncPeriod,
        messagesForUpdate
            .sublist(min(MESSAGES_PER_CHUNK, messagesForUpdate.length)),
        folderMessageCount,
        currentFolder,
      );
    }
  }

  // returns list of uids to load
  Future<List<Message>> _getMessageInfoWithNotBody(
      List<MessageInfo> messagesInfo) async {
    logger.log("method _getMessageInfoWithNotBody");
    final List<Message> messages = [];

    final length = messagesInfo.length;
    final step = 300;
    final count = length ~/ step;

    for (var i = 0; i <= count; i++) {
      final position = step * i;
      final uids = messagesInfo
          .sublist(position, min(position + step, messagesInfo.length))
          .map((item) => item.uid)
          .toList();

      messages
          .addAll(await _mailDao.getMessageWithNotBody(uids, account, user));
    }

    return messages;
  }

  Future<void> setMessagesSeen({
    @required Folder folder,
    @required List<Message> messages,
    @required bool isSeen,
  }) async {
    logger.log("method setMessagesSeen");
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
          hasThread: m.hasThread,
        );
      }).toList();
      await _mailDao.updateMessagesFlags(infos);
    }

    try {
      await updateMessages(isSeen);
      await _mailApi.setMessagesSeen(
        folder: folder,
        uids: messages.map((m) => m.uid).toList(),
        isSeen: isSeen,
      );
    } catch (err, s) {
      logger.error(err, s);
      updateMessages(!isSeen);
    }
  }

  Future<void> setMessagesStarred({
    @required Folder folder,
    @required List<Message> messages,
    @required bool isStarred,
  }) async {
    logger.log("method setMessagesStarred");
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
    } catch (err, s) {
      logger.error(err, s);
      updateMessages(!isStarred);
    }
  }

  Future<List<Folder>> _getOfflineFolders() async {
    final List<LocalFolder> localFolders =
        await _foldersDao.getAllFolders(account.localId);
    return Folder.getFoldersObjectsFromDb(localFolders);
  }

  Future<void> setEmailSafety(String senderEmail) async {
    await _mailApi.setEmailSafety(senderEmail: senderEmail);
  }

  Future<Message> getMessage(int localId) {
    return _mailDao.getMessage(localId);
  }

  Future<Folder> getFolder(String guid) {
    return _foldersDao.getFolderByGuId(guid);
  }

  static String currentFolderUpdate = null;

  Future<LocalFolder> getFolderByType(FolderType folderType) {
    return _foldersDao.getByType([Folder.getNumberFromFolderType(folderType)],
        account.localId).then((value) => value.isEmpty ? null : value.first);
  }

  void close() {
    syncQueue.clear();
    _closed = true;
  }

  Future<Message> getMessageById(String messageId, String folder) async {
    try {
      var message = await _mailDao.getMessageById(messageId, folder);
      if (message != null) {
        return message;
      } else {
        var messageInfos = await FolderMessageInfo.getMessageInfo(
          folder,
          account.localId,
        );
        final lastUid =
            messageInfos?.isNotEmpty == true ? messageInfos.first.uid : null;
        if (lastUid == null) {
          throw ErrorToShow.code(S.error_message_not_found);
        }
        final response = await _mailApi.getMessageById(
          messageId,
          folder,
          lastUid,
        );
        if (response == null) {
          throw ErrorToShow.code(S.error_message_not_found);
        }
        final messageInfo = MessageInfo(
          uid: response["Uid"] as int,
          hasThread: false,
          flags: [],
        );
        message = await _mailDao.getMessageByUid(
          messageInfo.uid,
          folder,
          account,
          user,
        );
        if (message != null) {
          if (message.hasBody == true) {
            return message;
          }
        } else {
          messageInfos = await FolderMessageInfo.getMessageInfo(
            folder,
            account.localId,
          );
          try {
            message = await _mailDao.addEmptyMessage(
                messageInfo, account, user, folder);
            messageInfos.insert(0, messageInfo);
            await FolderMessageInfo.setMessageInfo(
              folder,
              account.localId,
              messageInfos,
            );
          } catch (e) {
            message = await _mailDao.getMessageByUid(
              messageInfo.uid,
              folder,
              account,
              user,
            );
            if (message.hasBody == true) {
              return message;
            }
          }
        }
        final newMessages =
            await Mail.getMessageObjFromServerAndUpdateInfoHasBody(
          [response],
          [message],
          user.localId,
          account,
        );
        return _mailDao.fillMessage(newMessages.first);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Folder> getFolderByName(String name) {
    return _foldersDao.getByName(name, account.localId).then(Folder.getFolderObjectsFromDb);
  }
}

class _FillMessageArg {
  final List result;
  final List<Message> messagesInfo;
  final int userLocalId;
  final Account account;

  _FillMessageArg(
      this.result, this.messagesInfo, this.userLocalId, this.account);
}
