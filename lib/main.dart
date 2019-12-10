import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'background/background_sink.dart';
import 'modules/app_screen.dart';

var isBackground = true;

void main() {
  runApp(App());
  Alarm.onPeriodic(onAlarm);
}

@pragma('vm:entry-point')
void onAlarm() async {
  if (isBackground) {
    WidgetsFlutterBinding.ensureInitialized();

    await BackgroundSync().sync();

    Alarm.endAlarm();
  }
}
