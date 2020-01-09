import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  setOnNotification(Future Function(int, String, String, String) callback) {
    plugin.didReceiveLocalNotificationCallback = callback;
  }

  onSelectNotification() {}

  showNotification(String title, String body) {
    plugin.cancel(_id);
    plugin.show(
        _id, title, body, NotificationDetails(_notificationDetails, null));
  }

  static const _id = 341;
  static final _notificationDetails = AndroidNotificationDetails(
    "main",
    "New messages",
    "" /*todo description*/,
    importance: Importance.Max,
    priority: Priority.High,
  );
}
