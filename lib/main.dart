import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'modules/app_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  runApp(App());
  await Alarm.periodic(Duration, callback)
}

@pragma('vm:entry-point')
void onAlarm() {}
