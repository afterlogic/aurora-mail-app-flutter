import 'dart:io';
import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/main.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

import 'notification_manager.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  static final PushNotificationsManager instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  init() async {
    if (!_initialized && BuildProperty.pushNotification) {
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

  Future<String> getToken() {
    return _firebaseMessaging.getToken();
  }

  Future<String> getIMEI() async {
    return await DeviceId.getID;
  }
}

Future<dynamic> messageHandler(Map<String, dynamic> message) async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = AuthLocalStorage();

  if ((await localStorage.getSelectedUserLocalId()) != null) {
    final notification = NotificationData.fromMap(message);
    try {
      await onAlarm(false, notification);
    } catch (e) {
      print(e);
    }

    if (BackgroundHelper.isBackground) {
      final _usersDao = UsersDao(DBInstances.appDB);
      final _accountsDao = AccountsDao(DBInstances.appDB);
      final users = await _usersDao.getUsers();
      for (var user in users) {
        final accounts = await _accountsDao.getAccounts(user.localId);
        for (var value in accounts) {
          if (value.email == notification.to) {
            final manager = NotificationManager();
            manager.showNotification(
              notification.from,
              notification.subject,
              user,
            );
            return;
          }
        }
      }
    }
  }
}

class NotificationData {
  final String subject;
  final String to;
  final String from;

  NotificationData(this.subject, this.to, this.from);

  static NotificationData fromMap(Map<String, dynamic> message) {
    final notification = message["data"] as Map;

    return NotificationData(
      notification["Subject"] as String,
      notification["To"] as String,
      notification["From"] as String,
    );
  }
}
