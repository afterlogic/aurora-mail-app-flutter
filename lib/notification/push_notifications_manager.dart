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
          onMessage: myBackgroundMessageHandler, onBackgroundMessage: myBackgroundMessageHandler);
      _firebaseMessaging.onIosSettingsRegistered.listen((setting) {
        setting;
      });
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  WidgetsFlutterBinding.ensureInitialized();
  final manager = NotificationManager();
  manager.showNotification(message.toString());
}
