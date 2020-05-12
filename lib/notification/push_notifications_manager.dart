import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/main.dart';
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
    if (!_initialized) {
      await _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: foregroundMessageHandler,
        onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
        onLaunch: foregroundMessageHandler,
        onResume: foregroundMessageHandler,
      );
      _firebaseMessaging.onIosSettingsRegistered.listen((setting) {
        setting;
      });
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }

  Future<String> getToken() {
    return _firebaseMessaging.getToken();
  }
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  final notification = Notification.fromMap(message);
  WidgetsFlutterBinding.ensureInitialized();
  try {
    onAlarm(false);
  } catch (e) {
    print(e);
  }
  final manager = NotificationManager();
  manager.showNotification(notification.body, notification.title);
}

Future<dynamic> foregroundMessageHandler(Map<String, dynamic> message) async {
  final notification = Notification.fromMap(message);
  WidgetsFlutterBinding.ensureInitialized();
  try {
    onAlarm(false);
  } catch (e) {
    print(e);
  }

  final manager = NotificationManager();

  manager.showNotification(notification.body, notification.title);
}

class Notification {
  final String body;
  final String title;

  Notification(this.body, this.title);

  static Notification fromMap(Map<String, dynamic> message) {
    final notification = message["notification"] as Map;
    final body = notification["body"] as String;
    final title = notification["title"] as String;
    return Notification(body, title);
  }
}

Future<String> getIMEI() async {
  try {
    return await DeviceId.getMEID;
  } catch (e) {
    try {
      return await DeviceId.getIMEI;
    } catch (e) {
      return await DeviceId.getID;
    }
  }
}

class UpdatedMessageInfo {
  User user;
}
