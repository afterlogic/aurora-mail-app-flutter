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
import 'package:intl/intl.dart';

class BackgroundSync {
  final _mailDao = MailDao(DBInstances.appDB);
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _usersDao = UsersDao(DBInstances.appDB);
  final _accountsDao = AccountsDao(DBInstances.appDB);
  final _authLocal = AuthLocalStorage();
//  final _notificationStorage = NotificationLocalStorage();

  Future<bool> sync(bool isBackground) async {
    print("MailSync: ${DateFormat('H:m:s').format(DateTime.now())} sync START");
    try {
      final newMessages = await getNewMessages();
      print("MailSync: ${DateFormat('H:m:s').format(DateTime.now())} sync END");
      if (newMessages.isNotEmpty) {
        if (isBackground == true) {
          print("MailSync: ${newMessages.length} new message(s)");
          newMessages.forEach((message) {
            showNewMessage(message);
          });
        } else {
          print("MailSync: Foreground mode, cannot send notifications");
        }

        return true;
      } else {
        print("MailSync: No messages to sync");
      }
    } catch (e, s) {
      print("MailSync: ERROR:$e,$s");
    }
    return false;
  }

  Future<List<Message>> getNewMessages() async {
    SettingsBloc.isOffline = false;
    if ((await _authLocal.getSelectedUserLocalId()) == null) {
      return [];
    }
//    await initUser();
    final newMessages = new List<Message>();
    final users = await _usersDao.getUsers();

    for (final user in users) {
//      final accountLocalId = await _authLocal.getSelectedAccountId();
      final accounts = await _accountsDao.getAccounts(user.localId);
      final account = accounts[0];

      final inboxFolder = await _foldersDao.getByType(
          1 /*FolderType.inbox*/, account.localId);

      final foldersToUpdate = (await updateFolderHash(inboxFolder))
          .where((item) => item.type == 1)
          .toList();

//      final userLocalId = await _authLocal.getSelectedUserLocalId();
//      final user = await _usersDao.getUserByLocalId(userLocalId);
      if (account == null) return new List<Message>();

      for (Folder folderToUpdate in foldersToUpdate) {
        // null messagesInfo means that the folder has never been synced before
        if (!folderToUpdate.needsInfoUpdate ||
            folderToUpdate.messagesInfo == null) {
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

        List<MessageInfo> messagesInfo = MessageInfo.flattenMessagesInfo(
            rawInfo);

        final result = await Folders.calculateMessagesInfoDiffAsync(
            folderToUpdate.messagesInfo, messagesInfo);

        if (result.addedMessages.isEmpty) break;

        result.addedMessages.removeWhere((m) => m.flags.contains("\\seen"));

        final uids = result.addedMessages.map((m) => m.uid);
        final rawBodies = await mailApi.getMessageBodies(
          folderName: folderToUpdate.fullNameRaw,
          uids: uids.toList(),
        );
        final newMessageBodies = Mail
            .getMessageObjFromServerAndUpdateInfoHasBody(
          rawBodies,
          result.addedMessages,
          user.localId,
          account,
        );

        await _foldersDao.setMessagesInfo(
            folderToUpdate.localId, result.updatedInfo);
        newMessages.addAll(newMessageBodies);
      }
    }
    await _mailDao.addMessages(newMessages);
    return newMessages;
  }

  Future<List<Folder>> updateFolderHash(List<LocalFolder> folders) async {

    final userLocalId = await _authLocal.getSelectedUserLocalId();
    final user = await _usersDao.getUserByLocalId(userLocalId);
    final accountLocalId = await _authLocal.getSelectedAccountId();
    final account = await _accountsDao.getAccount(accountLocalId);

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

  Future<void> initUser() async {
    final selectedUserId = await _authLocal.getSelectedUserLocalId();

    final futures = [
      _usersDao.getUserByLocalId(selectedUserId),
      _accountsDao.getAccounts(selectedUserId),
    ];

    final result = await Future.wait(futures);
    final user = result[0] as User;
    final accounts = result[1] as List<Account>;
    await _authLocal.setSelectedUserLocalId(user.localId);
    await _authLocal.setSelectedUserLocalId(accounts[0].localId);
    SettingsBloc.isOffline = false;
  }

  void showNewMessage(Message message) async {
    final manager = NotificationManager();
    manager.showNotification(message);
  }
}