import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:flutter/material.dart';

import 'background/background_sink.dart';
import 'modules/app_screen.dart';

var isBackground = true;
Function doOnAlarm;

void main() {
  isBackground = false;
  runApp(App());
  Alarm.init();
  Alarm.onPeriodic(onAlarm);
}

@pragma('vm:entry-point')
void onAlarm() async {
  try {
    if (isBackground) WidgetsFlutterBinding.ensureInitialized();

    final hasUpdate = await BackgroundSync()
        .sync(isBackground)
        .timeout(Duration(seconds: 60));

    if (hasUpdate) {
      doOnAlarm();
    }
  } catch (e, s) {
    print(e);
    print(s);
  } finally {
    await Alarm.endAlarm();
  }
}
