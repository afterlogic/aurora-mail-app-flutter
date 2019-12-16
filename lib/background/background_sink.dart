import 'dart:ui';

import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_methods.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/notification/notification_manager.dart';

import 'notification_local_storage.dart';

class BackgroundSync {
  //todo VO
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _usersDao = UsersDao(DBInstances.appDB);
  final _accountsDao = AccountsDao(DBInstances.appDB);
  final _authLocal = AuthLocalStorage();
  final _foldersApi = FoldersApi();
  final _mailApi = MailApi();
  final _notificationStorage = NotificationLocalStorage();

  Future<bool> sync(bool isBackground, bool isRunApp) async {
    try {
      final newMessageCount = await getNewMessageCount();
      if (newMessageCount != 0) {
        var messageCount = await _notificationStorage.getMessageCount() ?? 0;
        var hasNew = false;
        if (isRunApp) {
          messageCount += newMessageCount;
          hasNew=true;
        } else {
          hasNew=newMessageCount != messageCount;
          messageCount = newMessageCount;
        }

        if (isBackground) {
          await _notificationStorage.setMessageCount(messageCount);
        } else {
          await _notificationStorage.clear();
        }

        if (hasNew) {
          await showNewMessage(messageCount);
        }
        return hasNew;
      }
    } catch (e, s) {
      print("sync error:$e,$s");
    }
    return false;
  }

  Future<int> getNewMessageCount() async {
    if ((await _authLocal.getSelectedUserServerId()) == null) {
      return 0;
    }
    await initUser();
    //todo VO
    final inboxFolder = await _foldersDao.getByType(1 /*FolderType.inbox*/);

    final foldersToUpdate = (await updateFolderHash(inboxFolder))
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

      newMessageCount += result.addedMessagesLength ?? 0;
    }
    return newMessageCount;
  }

  Future<List<Folder>> updateFolderHash(List<LocalFolder> folders) async {
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
        count: count,
        unread: unread,
        fullNameHash: newHash,
        needsInfoUpdate: needsInfoUpdate,
      ));
    });
    return Folder.getFolderObjectsFromDb(outFolder);
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

  showNewMessage(int newMessageCount) async {
    final locale = S.delegate.supportedLocales.firstWhere(
      (locale) {
        //todo VO locale
        return false;
      },
      orElse: () => Locale("en", ""),
    );

    final s = await S.delegate.load(locale);

    final manager = NotificationManager();

    final countMessage = newMessageCount > 1 ? s.new_messages : s.new_message;
    manager.showNotification(countMessage,
        s.you_have_new_message(newMessageCount.toString(), countMessage));
  }
}
