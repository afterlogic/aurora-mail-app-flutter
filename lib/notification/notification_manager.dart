import 'dart:math';

import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide Message;
import 'package:notifications_utils/notifications_utils.dart';
import 'package:package_info/package_info.dart';

class NotificationManager {
  final plugin = FlutterLocalNotificationsPlugin();

  NotificationManager() {
    final initializationSettings = InitializationSettings(
      //todo VO res/drawable/app_icon.png
      AndroidInitializationSettings('app_icon'),
      IOSInitializationSettings(),
    );

    plugin.initialize(initializationSettings);
  }

  void setOnNotification(
      Future Function(int, String, String, String) callback) {
    plugin.didReceiveLocalNotificationCallback = callback;
  }

  void onSelectNotification() {}

  Future<void> showMessageNotification(Message message, User user) async {
    return showNotification(message.fromToDisplay, message.subject, user);
  }

  Future<void> showNotification(String from, String subject, User user) async {
    final activeNotifications =
        await NotificationsUtils.getActiveNotifications();

    final packageName = (await PackageInfo.fromPlatform()).packageName;

    final isFirstNotification = activeNotifications.where((n) {
      return n.packageName == packageName &&
          n.groupKey.contains(user.emailFromLogin);
    }).isEmpty;

    final groupKey = "$packageName.${user.emailFromLogin}";
    final groupChannelId = user.emailFromLogin;
    final groupChannelName = user.emailFromLogin;
    final groupChannelDescription = user.emailFromLogin;

    if (from.contains("@")) from = from.split("@")[0];

    final androidNotificationDetails = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      groupChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      style: AndroidNotificationStyle.Inbox,
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
    );

    if (isFirstNotification) {
      await plugin.show(
        id + 999999,
        from,
        subject,
        NotificationDetails(
            androidNotificationDetails..setAsGroupSummary = false, null),
      );
    }
  }
}
