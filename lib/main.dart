import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/bloc_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'background/background_helper.dart';
import 'background/background_sync.dart';
import 'modules/app_screen.dart';

void main() {
  Crashlytics.instance.enableInDevMode = false;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(RestartWidget(child: App()));
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
  BlocSupervisor.delegate = BlocLogger();
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
  } catch (e, s) {
    print(e);
    print(s);
  }

  BackgroundHelper.onEndAlarm(hasUpdate);

  await AlarmService.endAlarm(hasUpdate);
}
