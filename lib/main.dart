import 'dart:async';

import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:flutter/material.dart';

import 'background/background_sink.dart';
import 'modules/app_screen.dart';

var isBackground = true;
Function doOnAlarm;
final _streamController = new StreamController<void>.broadcast();

Stream<void> get alarmStream => _streamController.stream.asBroadcastStream();

void main() {
  isBackground = false;
  runApp(RestartWidget(child: App()));
  Alarm.init();
  Alarm.onPeriodic(onAlarm);
}
@pragma('vm:entry-point')
void onAlarm() async {
  await Alarm.init();
  try {
    if (!isBackground) _streamController.add(null);
    if (isBackground) WidgetsFlutterBinding.ensureInitialized();

    final hasUpdate = await BackgroundSync()
        .sync(isBackground, doOnAlarm != null)
        .timeout(Duration(seconds: 30));

    if (hasUpdate) {
      if (doOnAlarm != null) doOnAlarm();
    }
  } catch (e, s) {
    print(e);
    print(s);
  }
  await Alarm.endAlarm();
}
