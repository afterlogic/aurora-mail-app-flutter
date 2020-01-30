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

  void setOnNotification(Future Function(int, String, String, String) callback) {
    plugin.didReceiveLocalNotificationCallback = callback;
  }

  void onSelectNotification() {}

  void showNotification(Message message, User user) {
    String groupKey = "com.afterlogic.aurora.mail.${user.emailFromLogin}";
    String groupChannelId = user.emailFromLogin;
    String groupChannelName = user.emailFromLogin;
    String groupChannelDescription = user.emailFromLogin;

    final androidNotificationDetails = AndroidNotificationDetails(
      groupChannelId,
      groupChannelName,
      groupChannelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      style: AndroidNotificationStyle.Inbox,
      styleInformation: InboxStyleInformation(
        [message.subject],
        contentTitle: message.fromToDisplay,
        summaryText: user.emailFromLogin,
      ),
      groupKey: groupKey,
    );

    plugin.cancel(message.uid);
    plugin.show(
      message.uid,
      message.fromToDisplay,
      message.subject,
      NotificationDetails(androidNotificationDetails, null),
    );
  }
}
