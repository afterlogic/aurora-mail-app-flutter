import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'background/background_helper.dart';
import 'background/background_sync.dart';
import 'modules/app_screen.dart';

void main() {
  Crashlytics.instance.enableInDevMode = false;
  AppInjector.create();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(RestartWidget(child: App()));
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
}

@pragma('vm:entry-point')
void onAlarm() async {
  var hasUpdate = false;

  try {
    WidgetsFlutterBinding.ensureInitialized();

    BackgroundHelper.onStartAlarm();

    hasUpdate = await BackgroundSync()
        .sync(BackgroundHelper.isBackground)
        .timeout(Duration(seconds: 30));

    BackgroundHelper.onEndAlarm(hasUpdate);
  } catch (e, s) {
    print(e);
    print(s);
  }
  await AlarmService.endAlarm(hasUpdate);
}
