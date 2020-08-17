import 'dart:math';

import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_methods.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/notification/notification_manager.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class BackgroundSync {
  final _mailDao = MailDao(DBInstances.appDB);
  final _foldersDao = FoldersDao(DBInstances.appDB);
  final _usersDao = UsersDao(DBInstances.appDB);
  final _accountsDao = AccountsDao(DBInstances.appDB);
  final _authLocal = AuthLocalStorage();

//  final _notificationStorage = NotificationLocalStorage();

  Future<bool> sync(
    bool isBackground,
    bool showNotification,
    NotificationData notification,
  ) async {
    logger.log("MailSync: sync START");
    var hasUpdate = false;
    if (notification == null && MailMethods.syncQueue.isNotEmpty) {
      return false;
    }
    try {
      final users = await _usersDao.getUsers();

      for (final user in users) {
        var accounts = await _accountsDao.getAccounts(user.localId);
        if (notification != null) {
          accounts =
              accounts.where((item) => item.email == notification.to).toList();
        }
        if (accounts.isEmpty) {
          continue;
        }
        final newMessages = await _getNewMessages(user, accounts);
        if (newMessages.isNotEmpty) {
          if (true) {
            newMessages
                .sort((a, b) => a.timeStampInUTC.compareTo(b.timeStampInUTC));
            logger.log("MailSync: ${newMessages.length} new message(s)");
            if (showNotification != false) {
              for (final message in newMessages) {
                await _showNewMessage(message, user);
              }
            }
          } else {
            print("MailSync: Foreground mode, cannot send notifications");
          }

          hasUpdate = true;
        } else {
          logger.log("MailSync: No messages to sync");
        }
      }
      logger.log("MailSync: sync END");
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

  Future<List<Message>> _getNewMessages(
    User user,
    List<Account> accounts,
  ) async {
    SettingsBloc.isOffline = false;
    if ((await _authLocal.getSelectedUserLocalId()) == null) {
      return [];
    }
    final newMessages = new List<Message>();
    for (var account in accounts) {
      final inboxFolders = await _foldersDao.getByType(
          [Folder.getNumberFromFolderType(FolderType.inbox)], account.localId);
      if (inboxFolders.isEmpty) continue;

      final foldersToUpdate =
          (await _updateFolderHash(inboxFolders, user, account))
              .where((item) => item.type == 1)
              .toList();

      if (account == null) return new List<Message>();

      for (Folder folderToUpdate in foldersToUpdate) {
        final messagesInfo = await FolderMessageInfo.getMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
        );

        if (!folderToUpdate.needsInfoUpdate || messagesInfo == null) {
          continue;
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

        await _mailDao.deleteMessages(
            result.removedUids, folderToUpdate.fullNameRaw);

        await _mailDao.updateMessagesFlags(result.infosToUpdateFlags);

        await _mailDao.addEmptyMessage(
            result.addedMessages, account, user, folderToUpdate.fullNameRaw);

        final uids = result.addedMessages.map((m) => m.uid);
        final rawBodies = await mailApi.getMessageBodies(
          folderName: folderToUpdate.fullNameRaw,
          uids: uids.toList(),
        );

        final newMessageBodies =
            Mail.getMessageObjFromServerAndUpdateInfoHasBody(
          rawBodies,
          await _getMessageInfoWithNotBody(result.addedMessages),
          user.localId,
          account,
          folderToUpdate,
        );

        await _mailDao.fillMessage(newMessageBodies);
        await FolderMessageInfo.setMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
          newMessagesInfo,
        );
        final notSeenMessagesUids = result.addedMessages
            .where((m) => !m.flags.contains("\\seen"))
            .map((e) => e.uid)
            .toSet();
        newMessages.addAll(newMessageBodies
            .where((element) => notSeenMessagesUids.contains(element.uid)));
      }
    }
    return newMessages;
  }

  Future<List<Message>> _getMessageInfoWithNotBody(
      List<MessageInfo> messagesInfo) async {
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

      messages.addAll(await _mailDao.getMessageWithNotBody(uids));
    }

    return messages;
  }

  Future<List<Folder>> _updateFolderHash(
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

  Future<void> _showNewMessage(Message message, User user) async {
    final manager = NotificationManager.instance;
    return manager.showMessageNotification(message, user);
  }
}
