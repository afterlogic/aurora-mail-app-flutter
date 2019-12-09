import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'background/background_sink.dart';
import 'modules/app_screen.dart';

void main() => runApp(App());


@pragma('vm:entry-point')
void onAlarm() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BackgroundSync().sync();

  Alarm.endAlarm();
}
