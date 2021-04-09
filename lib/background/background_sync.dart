import 'dart:math';

import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_methods.dart';
import 'package:aurora_mail/modules/mail/repository/folders_api.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/notification/notification_manager.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

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
    Logger isolatedLogger,
    ApiInterceptor interceptor,
  ) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    if (notification == null && MailMethods.syncQueue.isNotEmpty) {
      return false;
    }
    if ((await _authLocal.getSelectedUserLocalId()) == null) {
      return false;
    }
    isolatedLogger.log("MAIL_SYNC: sync start isBackground:$isBackground");
    var hasUpdate = false;

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
        final newMessages = await ((notification != null && isBackground)
            ? _getNewMessages(user, accounts, interceptor, isolatedLogger)
            : _updateAccountMessages(
                isBackground, user, accounts, interceptor, isolatedLogger));
        if (newMessages.isNotEmpty) {
          if (showNotification == true) {
            isolatedLogger
                .log("MailSync: ${newMessages.length} new message(s)");
            for (final entity in newMessages.entries) {
              entity.value
                  .sort((a, b) => a.timeStampInUTC.compareTo(b.timeStampInUTC));
              for (final message in entity.value) {
                await _showNewMessage(message, entity.key, user);
              }
            }
          }

          hasUpdate = true;
        } else {
          isolatedLogger.log("MailSync: No messages to sync");
        }
      }
      final now = DateTime.now().millisecondsSinceEpoch;
      final delay = (now - start) / 1000;
      isolatedLogger.log("MailSync: sync end in ${delay.toStringAsFixed(1)} s");
    } catch (e, s) {
      isolatedLogger.error(e, s);
      FirebaseCrashlytics.instance.recordFlutterError(
        FlutterErrorDetails(exception: e, stack: s),
      );
    }
    return hasUpdate;
  }

  Future<Map<Account, List<Message>>> _updateAccountMessages(
    bool isBackground,
    User user,
    List<Account> accounts,
    ApiInterceptor interceptor,
    Logger isolatedLogger,
  ) async {
    final newMessages = <Account, List<Message>>{};
    for (var account in accounts) {
      final inboxFolders = await (isBackground
          ? _foldersDao.getByType(
              [Folder.getNumberFromFolderType(FolderType.inbox)],
              account.localId)
          : _foldersDao.getAllFolders(account.localId));
      if (inboxFolders.isEmpty) continue;

      final foldersToUpdate =
          (await _updateFolderHash(inboxFolders, user, account, interceptor))
              .toList();

      if (account == null) continue;
      final folderGuidToUpdateMessage = {
        MailBloc.selectedFolderGuid,
        ...inboxFolders
            .where(
              (element) => [
                Folder.getNumberFromFolderType(FolderType.inbox),
                Folder.getNumberFromFolderType(FolderType.sent),
                Folder.getNumberFromFolderType(FolderType.drafts),
              ].contains(element.type),
            )
            .map((e) => e.guid)
      };
      for (Folder folderToUpdate in foldersToUpdate) {
        final messagesInfo = await FolderMessageInfo.getMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
        );
        final allowUpdateMessage = folderGuidToUpdateMessage.firstWhere(
              (element) => folderToUpdate.guid == element,
              orElse: () => null,
            ) !=
            null;
        if (folderToUpdate.needsInfoUpdate) {
          await _foldersDao.updateFolder(
            FoldersCompanion(
                needsInfoUpdate: Value(folderToUpdate.needsInfoUpdate)),
            folderToUpdate.guid,
          );
        }
        if (!folderToUpdate.needsInfoUpdate ||
            messagesInfo == null ||
            !allowUpdateMessage) {
          continue;
        }

        final syncPeriod = SyncPeriod.dbStringToPeriod(user.syncPeriod);
        final periodStr = SyncPeriod.periodToDate(syncPeriod);

        final mailApi = MailApi(
          user: user,
          account: account,
          interceptor: interceptor,
        );

        final rawInfo = await mailApi.getMessagesInfo(
            folderName: folderToUpdate.fullNameRaw, search: "date:$periodStr/");

        List<MessageInfo> newMessagesInfo =
            MessageInfo.flattenMessagesInfo(rawInfo);

        final result = await Folders.calculateMessagesInfoDiffAsync(
          messagesInfo,
          newMessagesInfo,
          true,
          true,
        );

        if (result.addedMessages.isEmpty) break;

        await _mailDao.deleteMessages(
            result.removedUids, folderToUpdate.fullNameRaw);

        await _mailDao.updateMessagesFlags(result.infosToUpdateFlags);
        isolatedLogger.log("start add empty message");
        await _mailDao.addEmptyMessages(
            result.addedMessages, account, user, folderToUpdate.fullNameRaw);
        isolatedLogger.log("finish add empty message");
        final uids = result.addedMessages.map((m) => m.uid);
        final rawBodies = await mailApi.getMessageBodies(
          folderName: folderToUpdate.fullNameRaw,
          uids: uids.toList(),
        );
        isolatedLogger.log("rawBodies: \n$rawBodies");
        final messageBody = await _getMessageInfoWithNotBody(
            result.addedMessages, account, user);
        isolatedLogger.log("messageBody: \n$messageBody");
        final newMessageBodies =
            await Mail.getMessageObjFromServerAndUpdateInfoHasBody(
          rawBodies,
          messageBody,
          user.localId,
          account,
        );

        await _mailDao.fillMessages(newMessageBodies);
        await FolderMessageInfo.setMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
          newMessagesInfo,
        );
        final notSeenMessagesUids = result.addedMessages
            .where((m) => !m.flags.contains("\\seen"))
            .map((e) => e.uid)
            .toSet();
        newMessages[account] = newMessageBodies
            .where((element) => notSeenMessagesUids.contains(element.uid))
            .toList();
      }
    }
    return newMessages;
  }

  Future<Map<Account, List<Message>>> _getNewMessages(
    User user,
    List<Account> accounts,
    ApiInterceptor interceptor,
    Logger isolatedLogger,
  ) async {
    final newMessages = <Account, List<Message>>{};
    for (var account in accounts) {
      if (account == null) continue;
      final inboxFolders = await _foldersDao.getByType(
          [Folder.getNumberFromFolderType(FolderType.inbox)], account.localId);
      if (inboxFolders.isEmpty) continue;

      for (LocalFolder folderToUpdate in inboxFolders) {
        final messagesInfo = await FolderMessageInfo.getMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
        );

        if (messagesInfo == null) {
          continue;
        }
        final periodStr = SyncPeriod.subtractPeriodFromNow(Duration(days: 2));

        final mailApi = MailApi(
          user: user,
          account: account,
          interceptor: interceptor,
        );

        final rawInfo = await mailApi.getMessagesInfo(
          folderName: folderToUpdate.fullNameRaw,
          search: "date:$periodStr/",
          useThreading: false,
        );

        List<MessageInfo> newMessagesInfo =
            MessageInfo.flattenMessagesInfo(rawInfo);

        final result = await Folders.calculateMessagesInfoDiffAsync(
          messagesInfo,
          newMessagesInfo,
          true,
          true,
        );

        if (result.addedMessages.isEmpty) continue;

        await _mailDao.addEmptyMessages(
            result.addedMessages, account, user, folderToUpdate.fullNameRaw);

        final uids = result.addedMessages.map((m) => m.uid);

        final rawBodies = await mailApi.getMessageBodies(
          folderName: folderToUpdate.fullNameRaw,
          uids: uids.toList(),
        );

        await _foldersDao.updateFolder(
          FoldersCompanion(needsInfoUpdate: Value(true)),
          folderToUpdate.guid,
        );
        final mergeMessageInfo = mergeNewMessageInfo(
          messagesInfo,
          newMessagesInfo,
        );
        isolatedLogger.log(rawBodies);
        final messageBody = await _getMessageInfoWithNotBody(
            result.addedMessages, account, user);
        isolatedLogger.log(messageBody);
        final newMessageBodies =
            await Mail.getMessageObjFromServerAndUpdateInfoHasBody(
          rawBodies,
          messageBody,
          user.localId,
          account,
        );

        await _mailDao.fillMessages(newMessageBodies);
        await FolderMessageInfo.setMessageInfo(
          folderToUpdate.fullNameRaw,
          account.localId,
          mergeMessageInfo,
        );
        final notSeenMessagesUids = result.addedMessages
            .where((m) => !m.flags.contains("\\seen"))
            .map((e) => e.uid)
            .toSet();
        newMessages[account] = newMessageBodies
            .where((element) => notSeenMessagesUids.contains(element.uid))
            .toList();
      }
    }
    return newMessages;
  }

  Future<List<Message>> _getMessageInfoWithNotBody(
    List<MessageInfo> messagesInfo,
    Account account,
    User user,
  ) async {
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

      messages.addAll(await _mailDao.getMessageWithNotBody(
        uids,
        account,
        user,
      ));
    }

    return messages;
  }

  List<MessageInfo> mergeNewMessageInfo(
      List<MessageInfo> messagesInfo, List<MessageInfo> newMessagesInfo) {
    final mergeMessageInfo = <MessageInfo>[];
    final notExistMessagesInfo = <int, MessageInfo>{};
    for (var value in newMessagesInfo) {
      notExistMessagesInfo[value.uid] = value;
    }
    for (var value in messagesInfo) {
      mergeMessageInfo.add(value);
      if (notExistMessagesInfo.containsKey(value.uid)) {
        notExistMessagesInfo.remove(value.uid);
      }
    }
    mergeMessageInfo.addAll(notExistMessagesInfo.values);
    return mergeMessageInfo;
  }

  Future<List<Folder>> _updateFolderHash(
    List<LocalFolder> folders,
    User user,
    Account account,
    ApiInterceptor interceptor,
  ) async {
    final _foldersApi = FoldersApi(
      user: user,
      account: account,
      interceptor: interceptor,
    );
    final newFolders = await _foldersApi.getRelevantFoldersInformation(
        folders.map((e) => e.fullNameRaw).toList());
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

  Future<void> _showNewMessage(
      Message message, Account account, User user) async {
    final manager = NotificationManager.instance;
    return manager.showMessageNotification(message, account, user);
  }
}
