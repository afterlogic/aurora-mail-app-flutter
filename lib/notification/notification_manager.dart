//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide Message;
import 'package:notifications_utils/notifications_utils.dart';
import 'package:package_info/package_info.dart';

class NotificationManager {
  final plugin = FlutterLocalNotificationsPlugin();
  static NotificationManager instance = NotificationManager._();

  NotificationManager._() {
    final initializationSettings = InitializationSettings(
      //todo VO res/drawable/app_icon.png
      android: AndroidInitializationSettings('app_icon'),
      iOS: IOSInitializationSettings(),
    );

    plugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _openFromNotification();
  }

  _openFromNotification() async {
    final notification = await plugin.getNotificationAppLaunchDetails();
    if (notification.didNotificationLaunchApp) {
      onSelectNotification(notification.payload);
    }
  }

  Future<void> showMessageNotification(
      Message message, Account account, User user) async {
    return showNotification(
        message.fromToDisplay, message.subject, account, user, message.localId);
  }

  Future<void> showNotification(
      String from, String subject, Account account, User user, int localId,
      {Map<String, dynamic> forcePayload}) async {
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    bool isFirstNotification = false;
    if (!Platform.isIOS) {
      final activeNotifications =
          await NotificationsUtils.getActiveNotifications();
      isFirstNotification = activeNotifications.where((n) {
        return n.packageName == packageName &&
            n.groupKey.contains(user.emailFromLogin);
      }).isEmpty;
    }

    String payload;
    if (forcePayload != null) {
      payload = jsonEncode(forcePayload);
    } else {
      payload = localId == null
          ? null
          : jsonEncode(
              {
                "user": user.localId,
                "message": localId,
                "account": account.localId,
              },
            );
    }

    final id = Random().nextInt(1 << 30);
    await plugin.show(
      id,
      from,
      subject,
      NotificationDetails(
        android: AndroidNotificationDetails("default", "Default"),
        iOS: null,
      ),
      payload: payload,
    );
  }
}

Future onSelectNotification(String payload) async {
  if (payload == null) {
    return;
  }

  final json = jsonDecode(payload) as Map<String, dynamic>;
  if (RouteWrap.staticState != null) {
    RouteWrap.staticState.onMessage(json);
  } else {
    RouteWrap.notification = json;
  }
}

const NOTIFICATION_MAIL_CHANNEL_ID = "new_mail";
const NOTIFICATION_MAIL_CHANNEL_NAME = "New mail";
const NOTIFICATION_MAIL_CHANNEL_DESCRIPTION = "";
