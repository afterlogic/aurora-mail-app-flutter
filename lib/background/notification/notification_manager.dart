import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final plugin = FlutterLocalNotificationsPlugin();

  NotificationManager() {
    final initializationSettings = InitializationSettings(
      AndroidInitializationSettings('app_icon'),
      IOSInitializationSettings(),
    );

    plugin.initialize(initializationSettings);
  }

  setOnNotification(Future Function(int, String, String, String) callback) {
    plugin.didReceiveLocalNotificationCallback = callback;
  }

  onSelectNotification() {}

  showNotification() {
    plugin.cancel(_id);
    plugin.show(_id, "", "", NotificationDetails(_notificationDetails, null));
  }

  static const _id = 341;
  static final _notificationDetails = AndroidNotificationDetails(
    "main",
    "update mail",
    "",
    importance: Importance.Max,
    priority: Priority.High,
    groupKey: "main",
  );
}
