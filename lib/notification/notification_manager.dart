import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' hide Message;

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

  showNotification(Message message) {
    plugin.cancel(message.uid);
    plugin.show(
      message.uid,
      message.fromToDisplay,
      message.subject,
      NotificationDetails(_notificationDetails, null),
    );
  }

  static final _notificationDetails = AndroidNotificationDetails(
    "main",
    "New messages",
    "" /*todo description*/,
    importance: Importance.Max,
    priority: Priority.High,
  );
}
