import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/utils/constants.dart';
import 'package:moor_flutter/moor_flutter.dart';

class MailMethods {
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _mailDao = new MailDao(DBInstances.appDB);
  final _foldersApi = new FoldersApi();
  final _mailApi = new MailApi();

  final _syncQueue = new List<int>();

  Future<List<Folder>> getFolders() async {
    // try to get from DB
    final List<LocalFolder> localFolders = await _foldersDao.getAllFolders();

    // if there folders in DB, return them and check if they need to be updated
    if (localFolders != null && localFolders.isNotEmpty) {
      return Folder.getFolderObjectsFromDb(localFolders);
    } else {
      // else get from server
      final rawFolders = await _foldersApi.getFolders();

      // first convert rawFolders to the format, which sql will accept and add to DB
      final newFolders =
          await Folders.getFolderObjectsFromServerAsync(rawFolders);
      await _foldersDao.addFolders(newFolders);

      final newFoldersWithIds = await _foldersDao.getAllFolders();
      return Folder.getFolderObjectsFromDb(newFoldersWithIds);
    }
  }

  Future<List<Folder>> refreshFolders() async {
    // fetch new folders
    final rawFoldersFuture = _foldersApi.getFolders();
    // fetch old folders
    final oldLocalFoldersFuture = _foldersDao.getAllFolders();

    // run fetching ops in parallel
    final futureWaitResult = await Future.wait([
      rawFoldersFuture,
      oldLocalFoldersFuture,
    ]);

    // get result
    final rawFolders = futureWaitResult[0];
    final oldLocalFolders = futureWaitResult[1];

    // convert new folders to db-like format (the format of old folders) for calculating difference
    final newLocalFolders =
        await Folders.getFolderObjectsFromServerAsync(rawFolders);

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
          removedFolders.map((f) => f.fullNameRaw);
      dbFutures.add(
          _mailDao.deleteMessagesFromRemovedFolders(removedFoldersRawNames));
    }
    if (addedFolders.isNotEmpty) {
      dbFutures.add(_foldersDao.addFolders(addedFolders));
    }

    // if dbFutures IS empty, then no changes were detected
    if (dbFutures.isNotEmpty) {
      await Future.wait(dbFutures);

      final newFoldersWithIds = await _foldersDao.getAllFolders();
      return Folder.getFolderObjectsFromDb(newFoldersWithIds);
    } else {
      return Folder.getFolderObjectsFromDb(oldLocalFolders);
    }
  }

  Future<List<Folder>> updateFoldersHash(Folder selectedFolder,
      {bool forceCurrentFolderUpdate = false}) async {
    assert(selectedFolder != null);

    final localFolders = await _foldersDao.getAllFolders();

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
          count: Value(count),
          unread: Value(unread),
          fullNameHash: Value(newHash),
          needsInfoUpdate: Value(needsInfoUpdate),
        ),
        folder.localId,
      ));
    });

    await Future.wait(futures);
    final updatedLocalFolders = await _foldersDao.getAllFolders();
    return Folder.getFolderObjectsFromDb(updatedLocalFolders);
  }

  Stream<List<Message>> subscribeToMessages(Folder folder) {
    return _mailDao.watchMessages(folder.fullNameRaw);
  }

  Future<void> syncFolders(
      {@required int localId, bool syncSystemFolders = false}) async {
    // either localId or syncSystemFolders must be provided
    assert(localId != null || syncSystemFolders != null);
    var localFolders = new List<LocalFolder>();
    if (syncSystemFolders == true) {
      localFolders = await _foldersDao.getAllFolders();
      localFolders.sort((a, b) => a.folderOrder.compareTo(b.folderOrder));
    }

    final queueLengthBeforeInsert = _syncQueue.length;

    localFolders.forEach((f) {
      if (f.isSystemFolder && !_syncQueue.contains(f.localId)) {
        _syncQueue.add(f.localId);
      }
    });

    if (localId != null) {
      if (_syncQueue.contains(localId)) _syncQueue.remove(localId);
      _syncQueue.insert(0, localId);
    }
    if (_syncQueue.isNotEmpty && queueLengthBeforeInsert == 0) {
      // TODO VO: completes earlier
      await _setMessagesInfoToFolder();
    }
  }

  Future<void> _setMessagesInfoToFolder() async {
    assert(_syncQueue.isNotEmpty);

    final folderToUpdate = await _foldersDao.getFolder(_syncQueue[0]);

    if (!folderToUpdate.needsInfoUpdate) {
      _syncQueue.remove(folderToUpdate.localId);
      if (_syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    }

    print("getting folder info for: ${folderToUpdate.fullNameRaw}");

    final rawInfo = await _mailApi.getMessagesInfo(
      folderName: folderToUpdate.fullNameRaw,
    );

    List<MessageInfo> messagesInfo = MessageInfo.flattenMessagesInfo(rawInfo);

    // calculate difference
    if (folderToUpdate.messagesInfo != null) {
      final calcResult = await Folders.calculateMessagesInfoDiffAsync(
          folderToUpdate.messagesInfo, messagesInfo);
      messagesInfo = calcResult.updatedInfo;
      await _mailDao.deleteMessages(calcResult.removedUids);
    }

    await _foldersDao.setMessagesInfo(folderToUpdate.localId, messagesInfo);

    return _syncMessagesChunk();
  }

  // step 5
  Future<void> _syncMessagesChunk() async {
    assert(_syncQueue.isNotEmpty);

    // get the actual folder state every time
    final folder = await _foldersDao.getFolder(_syncQueue[0]);
    if (folder.messagesInfo == null) {
      print(
          "Attention! messagesInfo is null, perhaps another folder was selected while messages info was being retrieved.");
      return _setMessagesInfoToFolder();
    }

    // TODO VO: make async
    final uids = _takeChunk(folder.messagesInfo);

    // if all messages are synced
    if (uids.length == 0) {
      print("All the messages have been synced for: ${folder.fullNameRaw}");
      await _foldersDao.updateFolder(
        new FoldersCompanion(
          needsInfoUpdate: Value(false),
        ),
        folder.localId,
      );
      assert(_syncQueue.contains(folder.localId));
      _syncQueue.remove(folder.localId);
      print("_syncQueue: $_syncQueue");
      if (_syncQueue.isNotEmpty) {
        return _setMessagesInfoToFolder();
      } else {
        return null;
      }
    } else {
      print("syncing messages for: ${folder.fullNameRaw}");
      final rawBodies = await _mailApi.getMessageBodies(
          folderName: folder.fullNameRaw, uids: uids);

      // TODO VO: make async
      final messages = Mail.getMessageObjFromServerAndUpdateInfoHasBody(
          rawBodies, folder.messagesInfo);

      await _mailDao.addMessages(messages);

      await _foldersDao.setMessagesInfo(folder.localId, folder.messagesInfo);

      // check if there are other messages to sync
      return _syncMessagesChunk();
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

  void downloadAttachment(
    MailAttachment attachment, {
    @required Function(String) onDownloadEnd,
    @required Function() onDownloadStart,
  }) {
    _mailApi.downloadAttachment(attachment,
        onDownloadEnd: onDownloadEnd, onDownloadStart: onDownloadStart);
  }
}
