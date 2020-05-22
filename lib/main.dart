import 'dart:io';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/bloc_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/logger/logger_view.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'background/background_helper.dart';
import 'background/background_sync.dart';
import 'logger/logger.dart';
import 'modules/app_screen.dart';

void main() async {
  Crashlytics.instance.enableInDevMode = true;

  AppInjector.create();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  // ignore: invalid_use_of_protected_member
  DBInstances.appDB.connection.executor.ensureOpen();
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationsManager.instance.init();
  runApp(
    LoggerView.wrap(
      FutureBuilder(
        future: DBInstances.appDB.migrationCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RestartWidget(child: App());
          } else {
            return Container();
          }
        },
      ),
    ),
  );
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
  BlocSupervisor.delegate = BlocLogger();
  try {
    if (Platform.isAndroid) FlutterDownloader.initialize();
  } catch (e) {
    e;
  }
}

Set<String> updateForNotification = {};

@pragma('vm:entry-point')
void onAlarm([bool showNotification = true, NotificationData data]) async {
  var hasUpdate = false;
  if (!updateForNotification.contains(null) &&
      !updateForNotification.contains(data?.to)) {
    updateForNotification.add(data?.to);
    try {
      WidgetsFlutterBinding.ensureInitialized();

      BackgroundHelper.onStartAlarm();

      hasUpdate = await BackgroundSync()
          .sync(BackgroundHelper.isBackground, showNotification, data)
          .timeout(Duration(seconds: kDebugMode ? 360 : 30));
    } catch (e, s) {
      logger.log("onAlarm exeption $e");
      print(s);
    }
    updateForNotification.remove(data?.to);
  }
  BackgroundHelper.onEndAlarm(hasUpdate);

  await AlarmService.endAlarm(hasUpdate);
}
