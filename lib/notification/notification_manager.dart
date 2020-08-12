import 'dart:io';
import 'dart:math';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/app_screen.dart';
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
      AndroidInitializationSettings('app_icon'),
      IOSInitializationSettings(),
    );

    plugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    test();
  }

  test() async {
    final notification = await plugin.getNotificationAppLaunchDetails();
    if (notification.didNotificationLaunchApp) {
      onSelectNotification(notification.payload);
    }
  }

  Future<void> showMessageNotification(Message message, User user) async {
    return showNotification(
        message.fromToDisplay, message.subject, user, message.uid);
  }

  Future<void> showNotification(
      String from, String subject, User user, int uid) async {
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

    final groupKey = "$packageName.${user.emailFromLogin}";
    final groupChannelId = user.emailFromLogin;
    final groupChannelName = user.emailFromLogin;
    final groupChannelDescription = user.emailFromLogin;

    if (from.contains("@")) from = from.split("@")[0];

    var androidNotificationDetails = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      groupChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      styleInformation: InboxStyleInformation(
        [subject],
        contentTitle: from,
        summaryText: user.emailFromLogin,
      ),
      groupKey: groupKey,
      setAsGroupSummary: isFirstNotification,
    );

    final id = Random().nextInt(1 << 30);
    await plugin.show(
      id,
      from,
      subject,
      NotificationDetails(androidNotificationDetails, null),
      payload: "$uid",
    );

    if (isFirstNotification) {
      androidNotificationDetails = AndroidNotificationDetails(
        NOTIFICATION_MAIL_CHANNEL_ID,
        NOTIFICATION_MAIL_CHANNEL_NAME,
        NOTIFICATION_MAIL_CHANNEL_DESCRIPTION,
        importance: Importance.Max,
        priority: Priority.High,
        styleInformation: InboxStyleInformation(
          [subject],
          contentTitle: from,
          summaryText: user.emailFromLogin,
        ),
        groupKey: groupKey,
        setAsGroupSummary: false,
      );
      await plugin.show(
        id + 999999,
        from,
        subject,
        NotificationDetails(androidNotificationDetails, null),
        payload: "${user.localId}|$uid",
      );
    }
  }
}

Future onSelectNotification(String payload) async {
  await Future.delayed(Duration(seconds: 1));
  final data=payload.split("|");
  final userLocalId = int.tryParse(data[0]);
  final messageUid = int.tryParse(data[1]);
  RouteWrap.staticState.showMessage(userLocalId,messageUid);
}

const NOTIFICATION_MAIL_CHANNEL_ID = "new_mail";
const NOTIFICATION_MAIL_CHANNEL_NAME = "New mail";
const NOTIFICATION_MAIL_CHANNEL_DESCRIPTION = "";
