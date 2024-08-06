//@dart=2.9
import 'dart:io';

import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/main.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/calendar_route.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:ios_notification_handler/ios_notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_manager.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  String deviceId;
  String token;
  NotificationData _initNotification = null;
  static final PushNotificationsManager instance = PushNotificationsManager._();

  NotificationData get initNotification{
    final res = _initNotification;
    _initNotification = null;
    return res;
  }

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
        ///terminated click handler
        final initMessage = await _firebaseMessaging.getInitialMessage();
        if(initMessage != null){
          _initNotification = NotificationData.fromMap(initMessage);
        }
        FirebaseMessaging.onBackgroundMessage(voidMessageHandler);
        FirebaseMessaging.onMessage.listen(messageHandler);
        FirebaseMessaging.onMessageOpenedApp.listen((v) => onResume(v));
        _initialized = true;
      }
    }
  }

  Future<String> getToken() async {
    token = await _firebaseMessaging.getToken();
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
  ///app minimized
  if (RouteWrap.staticState != null) {
    switch (notification.type){
      case 'email':
        RouteWrap.staticState.onMessage(payload);
        break;
      case 'calendar':
        RouteWrap.staticState.onCalendar(payload);
        break;
    }
  } else {
    ///terminate state
    RouteWrap.notification = payload;
  }
}

///foreground

Future<bool> mapMessageHandler(Map<String, dynamic> message) async {
  return messageHandler(RemoteMessage.fromMap(message));
}

Future<void> voidMessageHandler(RemoteMessage message) async {
  await messageHandler(message);
}

Future<bool> messageHandler(RemoteMessage message) async {
  if (Platform.isAndroid && !BackgroundHelper.appIsRunning) {
    return false;
  }
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
                'notificationsubject',
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
          recordLog: false);
    } catch (e, s) {
      Logger.errorLog(e, s);
    }
  } else {
    Logger.errorLog("handle push without user", null);
  }
  return false;
}

final notificationFromPush = true;

enum NotificationType { email, calendar }

extension NotificationTypeMapper on NotificationType {
  static NotificationType fromString(String s) {
    switch (s) {
      case 'calendar':
        return NotificationType.calendar;
      case 'email':
      default:
        return NotificationType.email;
    }
  }

  String toStringCode() {
    switch (this) {
      case NotificationType.email:
        return 'email';
      case NotificationType.calendar:
        return 'calendar';
      default:
        throw Exception('Unknown NotificationType');
    }
  }
}

class NotificationData {
  final String type;
  final String subject;
  final String to;
  final String from;
  final String messageID;
  final String folder;
  final String calendarId;
  final String activityId;

  NotificationData(
      this.subject, this.to, this.from, this.messageID, this.folder,
      this.type, this.calendarId, this.activityId);

  static NotificationData fromMap(RemoteMessage message) {
    final notification = message.data;

    return NotificationData(
      notification["Subject"] as String,
      notification["To"] as String,
      notification["From"] as String,
      notification["MessageId"] as String,
      notification["Folder"] as String,
      notification["Type"] as String,
      notification["Calendar_id"] as String,
      notification["Event_uid"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "Subject": subject,
        "To": to,
        "From": from,
        "MessageId": messageID,
        "Folder": folder,
        "Type": type,
        "Calendar_id": calendarId,
        "Event_uid": activityId
      };
}
