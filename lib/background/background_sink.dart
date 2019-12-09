import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_methods.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/notification/notification_manager.dart';

class BackgroundSync {
  //todo VO
  final _mailMethods = MailMethods();
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _usersDao = UsersDao(DBInstances.appDB);
  final _accountsDao = AccountsDao(DBInstances.appDB);
  final _authLocal = AuthLocalStorage();
  final _mailApi = MailApi();

  sync() async {
    try {
      final newMessageCount = await getNewMessageCount();
      if (newMessageCount != 0) {
        showNewMessage(newMessageCount);
      }
    } catch (e, s) {
      print("sync error:$e,$s");
    }
  }

  Future<int> getNewMessageCount() async {
    if ((await _authLocal.getSelectedUserServerId()) == null) {
      return 0;
    }
    await initUser();
    //todo VO
    final inboxFolder = Folder.getFolderObjectsFromDb(
        await _foldersDao.getByType(1 /*FolderType.inbox*/));

    final foldersToUpdate = (await _mailMethods.updateFoldersHash(
      inboxFolder.first,
      forceCurrentFolderUpdate: true,
    ))
        .where((item) => item.type == 1)
        .toList();

    var newMessageCount = 0;
    for (Folder folderToUpdate in foldersToUpdate) {
      if (!folderToUpdate.needsInfoUpdate) {
        continue;
      }

      final user =
          await _usersDao.getUserByLocalId(AuthBloc.currentUser.localId);

      final syncPeriod = SyncPeriod.dbStringToPeriod(user.syncPeriod);
      final periodStr = SyncPeriod.periodToDate(syncPeriod);

      final rawInfo = await _mailApi.getMessagesInfo(
          folderName: folderToUpdate.fullNameRaw, search: "date:$periodStr/");

      List<MessageInfo> messagesInfo = MessageInfo.flattenMessagesInfo(rawInfo);

      final result = await Folders.calculateMessagesInfoDiffAsync(
          folderToUpdate.messagesInfo, messagesInfo);

      await _foldersDao.setMessagesInfo(folderToUpdate.localId, messagesInfo);

      newMessageCount += result.addedMessagesLength ?? 0;
    }
    return newMessageCount;
  }

  //todo VO init static field
  initUser() async {
    final selectedUserServerId = await _authLocal.getSelectedUserServerId();

    final futures = [
      _usersDao.getUserByServerId(selectedUserServerId),
      _accountsDao.getAccounts(selectedUserServerId),
    ];

    final result = await Future.wait(futures);
    final User user = result[0];
    final List<Account> accounts = result[1];
    AuthBloc.currentAccount = accounts[0];
    AuthBloc.hostName = user.hostname;
    AuthBloc.currentUser = user;
    SettingsBloc.isOffline = false;
  }

  showNewMessage(int newMessageCount) {
    final manager = NotificationManager();
    final countMessage = newMessageCount > 1 ? "new messages" : "new message";
    manager.showNotification("New messages", "You have $newMessageCount $countMessage");
  }
}
