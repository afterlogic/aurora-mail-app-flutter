import 'dart:io';
import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/main.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:ios_notification_handler/ios_notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_manager.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  String deviceId;
  static final PushNotificationsManager instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  init() async {
    if (BuildProperty.pushNotification) {
      if (!_initialized) {
        if (Platform.isIOS) {
          IosNotificationHandler.onMessage(messageHandler);
        }
        deviceId = await _getIMEI();
        await _firebaseMessaging.requestNotificationPermissions();
        _firebaseMessaging.configure(
          onMessage: messageHandler,
          onBackgroundMessage: Platform.isIOS ? null : messageHandler,
        );
        _firebaseMessaging.onIosSettingsRegistered.listen((setting) {
          setting;
        });
        _initialized = true;
      }
    }
  }

  Future<String> getToken() async {
    final token = await _firebaseMessaging.getToken();
    print(token);
    return token;
  }
  Future<String> _getIMEI() async {
    return await DeviceId.getID;
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

Future<bool> messageHandler(Map<dynamic, dynamic> message) async {
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
          for (var value in accounts) {
            if (value.email == notification.to) {
              final manager = NotificationManager.instance;
              manager.showNotification(
                notification.from,
                notification.subject,
                user,
                1,
              );
              break;
            }
          }
        }
      }
      return await onAlarm(
        showNotification: !notificationFromPush,
        data: notification,
      );
    } catch (e, s) {
      Logger.errorLog(e, s);
    }
  } else {
    Logger.errorLog("handle push with not user", null);
  }
  return false;
}

final notificationFromPush = false;

class NotificationData {
  final String subject;
  final String to;
  final String from;

  NotificationData(this.subject, this.to, this.from);

  static NotificationData fromMap(Map<dynamic, dynamic> message) {
    final notification = (message["data"] ?? message) as Map;

    return NotificationData(
      notification["Subject"] as String,
      notification["To"] as String,
      notification["From"] as String,
    );
  }
}
