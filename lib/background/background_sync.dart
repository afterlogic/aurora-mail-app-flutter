import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/notification/notification_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class BackgroundSync {
  final _mailDao = MailDao(DBInstances.appDB);
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _usersDao = UsersDao(DBInstances.appDB);
  final _accountsDao = AccountsDao(DBInstances.appDB);
  final _authLocal = AuthLocalStorage();

//  final _notificationStorage = NotificationLocalStorage();

  Future<bool> sync(bool isBackground) async {
    print("MailSync: sync START");
    var hasUpdate = false;
    try {
      final users = await _usersDao.getUsers();

      for (final user in users) {
        final newMessages = await getNewMessages(user);
        print("MailSync: sync END");
        if (newMessages.isNotEmpty) {
          if (isBackground == true) {
            newMessages
                .sort((a, b) => a.timeStampInUTC.compareTo(b.timeStampInUTC));
            print("MailSync: ${newMessages.length} new message(s)");

            for (final message in newMessages) {
              await showNewMessage(message, user);
            }
          } else {
            print("MailSync: Foreground mode, cannot send notifications");
          }

          hasUpdate = true;
        } else {
          print("MailSync: No messages to sync");
        }
      }
    }
//    on SocketException {
//
//    }
    catch (e, s) {
      Crashlytics.instance.recordFlutterError(
        FlutterErrorDetails(exception: e, stack: s),
      );
    }
    return hasUpdate;
  }

  Future<List<Message>> getNewMessages(User user) async {
    SettingsBloc.isOffline = false;
    if ((await _authLocal.getSelectedUserLocalId()) == null) {
      return [];
    }
//    await initUser();
    final newMessages = new List<Message>();

//      final accountLocalId = await _authLocal.getSelectedAccountId();
    final accounts = await _accountsDao.getAccounts(user.localId);
    final account = accounts[0];

    final inboxFolders =
        await _foldersDao.getByType(1 /*FolderType.inbox*/, account.localId);

    final foldersToUpdate =
        (await updateFolderHash(inboxFolders, user, account))
            .where((item) => item.type == 1)
            .toList();

    if (account == null) return new List<Message>();

    for (Folder folderToUpdate in foldersToUpdate) {
      final messagesInfo = await FolderMessageInfo.getMessageInfo(
        folderToUpdate.fullNameRaw,
        account.localId,
      );

      if (!folderToUpdate.needsInfoUpdate || messagesInfo == null) {
        break;
      }

      final syncPeriod = SyncPeriod.dbStringToPeriod(user.syncPeriod);
      final periodStr = SyncPeriod.periodToDate(syncPeriod);

      final mailApi = MailApi(
        user: user,
        account: account,
      );

      final rawInfo = await mailApi.getMessagesInfo(
          folderName: folderToUpdate.fullNameRaw, search: "date:$periodStr/");

      List<MessageInfo> newMessagesInfo =
          MessageInfo.flattenMessagesInfo(rawInfo);

      final result = await Folders.calculateMessagesInfoDiffAsync(
          messagesInfo, newMessagesInfo);

      if (result.addedMessages.isEmpty) break;

      result.addedMessages.removeWhere((m) => m.flags.contains("\\seen"));

      final uids = result.addedMessages.map((m) => m.uid);
      final rawBodies = await mailApi.getMessageBodies(
        folderName: folderToUpdate.fullNameRaw,
        uids: uids.toList(),
      );
      final newMessageBodies = Mail.getMessageObjFromServerAndUpdateInfoHasBody(
        rawBodies,
        null,
        user.localId,
        account,
      );
      await FolderMessageInfo.setMessageInfo(
        folderToUpdate.fullNameRaw,
        account.localId,
        result.updatedInfo,
      );
      await _mailDao.fillMessage(newMessageBodies);
      newMessages.addAll(newMessageBodies);
    }
    return newMessages;
  }

  Future<List<Folder>> updateFolderHash(
      List<LocalFolder> folders, User user, Account account) async {
    final _foldersApi = FoldersApi(
      user: user,
      account: account,
    );
    final newFolders = await _foldersApi.getRelevantFoldersInformation(folders);
    final outFolder = <LocalFolder>[];
    newFolders.keys.forEach((fName) {
      final updatedFolder = newFolders[fName];
      final folder = folders.firstWhere((f) => f.fullNameRaw == fName);

      final shouldUpdate = folder.needsInfoUpdate;

      final count = updatedFolder[0];
      final unread = updatedFolder[1];
      final newHash = updatedFolder[3];
      final needsInfoUpdate = folder.fullNameHash != newHash || shouldUpdate;

      outFolder.add(folder.copyWith(
        count: count as int,
        unread: unread as int,
        fullNameHash: newHash as String,
        needsInfoUpdate: needsInfoUpdate,
      ));
    });
    return Folder.getFolderObjectsFromDb(outFolder);
  }

//  Future<void> initUser() async {
//    final selectedUserId = await _authLocal.getSelectedUserLocalId();
//
//    final futures = [
//      _usersDao.getUserByLocalId(selectedUserId),
//      _accountsDao.getAccounts(selectedUserId),
//    ];
//
//    final result = await Future.wait(futures);
//    final user = result[0] as User;
//    final accounts = result[1] as List<Account>;
//    await _authLocal.setSelectedUserLocalId(user.localId);
//    await _authLocal.setSelectedUserLocalId(accounts[0].localId);
//    SettingsBloc.isOffline = false;
//  }

  Future<void> showNewMessage(Message message, User user) async {
    final manager = NotificationManager();
    return manager.showNotification(message, user);
  }
}
