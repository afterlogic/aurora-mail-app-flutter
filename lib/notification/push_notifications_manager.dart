import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/main.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:ios_notification_handler/ios_notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'notification_manager.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  String deviceId;
  static final PushNotificationsManager instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  init() async {
    if (BuildProperty.pushNotification) {
      if (!_initialized) {
        if (Platform.isIOS) {
          IosNotificationHandler.onMessage(mapMessageHandler);
        }
        deviceId = await DeviceIdStorage.getDeviceId();
        await _firebaseMessaging.requestPermission();
        FirebaseMessaging.onBackgroundMessage(voidMessageHandler);
        FirebaseMessaging.onMessage.listen(messageHandler);
        FirebaseMessaging.onMessageOpenedApp.listen((v) => onResume(v));

        _initialized = true;
      }
    }
  }

  Future<String> getToken() async {
    final token = await _firebaseMessaging.getToken();
    print(token);
    return token;
  }

  Future setTokenStatus(bool status) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setBool("token_status", status);
  }

  Future<bool> getTokenStatus() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getBool("token_status");
  }
}

Future onResume(RemoteMessage message) async {
  final notification = NotificationData.fromMap(message);
  final payload = notification.toJson();
  if (RouteWrap.staticState != null) {
    RouteWrap.staticState.onMessage(payload);
  } else {
    RouteWrap.notification = payload;
  }
}

Future<bool> mapMessageHandler(Map<String, dynamic> message) async {
  return messageHandler(RemoteMessage.fromMap(message));
}

Future<void> voidMessageHandler(RemoteMessage message) async {
  await messageHandler(message);
}

Future<bool> messageHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.notifications(message);
  final localStorage = AuthLocalStorage();

  if ((await localStorage.getSelectedUserLocalId()) != null) {
    final notification = NotificationData.fromMap(message);
    try {
      if (notificationFromPush) {
        final _usersDao = UsersDao(DBInstances.appDB);
        final _accountsDao = AccountsDao(DBInstances.appDB);
        final users = await _usersDao.getUsers();
        for (var user in users) {
          final accounts = await _accountsDao.getAccounts(user.localId);
          for (var account in accounts) {
            if (account.email == notification.to) {
              final manager = NotificationManager.instance;
              manager.showNotification(
                notification.from,
                notification.subject,
                account,
                user,
                null,
                forcePayload: notification.toJson(),
              );
              break;
            }
          }
        }
      }
      return await onAlarm(
        showNotification: !notificationFromPush,
        data: notification,
        isBackgroundForce: await IosNotificationHandler.isBackground(),
      );
    } catch (e, s) {
      Logger.errorLog(e, s);
    }
  } else {
    Logger.errorLog("handle push without user", null);
  }
  return false;
}

final notificationFromPush = true;

class NotificationData {
  final String subject;
  final String to;
  final String from;
  final String messageID;
  final String folder;

  NotificationData(
      this.subject, this.to, this.from, this.messageID, this.folder);

  static NotificationData fromMap(RemoteMessage message) {
    final notification = message.data;

    return NotificationData(
      notification["Subject"] as String,
      notification["To"] as String,
      notification["From"] as String,
      notification["MessageId"] as String,
      notification["Folder"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "Subject": subject,
        "To": to,
        "From": from,
        "MessageId": messageID,
        "Folder": folder,
      };
}
