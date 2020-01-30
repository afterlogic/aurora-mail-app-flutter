import 'dart:async';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:flutter/material.dart';

import 'background/background_sync.dart';
import 'modules/app_screen.dart';

var isBackground = true;
Function doOnAlarm;
final _streamController = new StreamController<void>.broadcast();

Stream<void> get alarmStream => _streamController.stream.asBroadcastStream();

void main() {
  isBackground = false;
  runApp(RestartWidget(child: App()));
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
}

@pragma('vm:entry-point')
void onAlarm() async {
  var hasUpdate = false;

  try {
    WidgetsFlutterBinding.ensureInitialized();
    AlarmService.init();

    if (!isBackground) _streamController.add(null);

    hasUpdate = await BackgroundSync()
        .sync(isBackground)
        .timeout(Duration(seconds: 30));

    if (hasUpdate) {
      if (doOnAlarm != null) doOnAlarm();
    }
  } catch (e, s) {
    print(e);
    print(s);
  }
  await AlarmService.endAlarm(hasUpdate);
}
