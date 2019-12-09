import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'background/notification/notification_manager.dart';
import 'modules/app_screen.dart';

var isForeground = false;

void main() async {
  isForeground = true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());

  await Alarm.periodic(Duration(seconds: 60), onAlarm);
}

@pragma('vm:entry-point')
void onAlarm() async {
  if (!isForeground) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  final manager = NotificationManager();
  manager.showNotification();

  if (!isForeground) {
    Alarm.endAlarm();
  }
}
