//@dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:timezone/data/latest.dart' as tz;
import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/bloc_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'background/background_helper.dart';
import 'background/background_sync.dart';
import 'build_property.dart';
import 'modules/app_screen.dart';
import 'modules/settings/screens/debug/debug_local_storage.dart';
import 'modules/settings/screens/debug/default_logger_interceptor_adapter.dart';
import 'modules/settings/screens/debug/logger_interceptor_adapter.dart';
import 'notification/notification_manager.dart';

void main() async {
  BackgroundHelper.appIsRunning = true;
  LoggerSetting.init(LoggerSetting(
    packageName: BuildProperty.packageName,
    defaultInterceptor: DefaultLoggerInterceptorAdapter(),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppInjector.create();

  if (!kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  // ignore: invalid_use_of_protected_member
  DBInstances.appDB.connection.executor.ensureOpen(DBInstances.appDB);
  LoggerStorage()
    ..getDebug().then((value) {
      if (value) logger.enable = true;
    })
    ..getIsRun().then((value) {
      if (value) logger.start();
    });
  PushNotificationsManager.instance.init();

  runZonedGuarded<void>(
    () => runApp(
      LoggerControllerWidget.wrap(
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
    ),
    (error, stack) {
      if (!kDebugMode) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
    },
  );

  NotificationManager.instance;
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
  AlarmService.onNotification(mapMessageHandler);
  Bloc.observer = BlocLogger();
  tz.initializeTimeZones();
  try {
    if (Platform.isAndroid) FlutterDownloader.initialize();
  } catch (e) {
    e;
  }
}

Set<String> updateFromNotification = {};

@pragma('vm:entry-point')
Future<bool> onAlarm({
  bool showNotification = true,
  NotificationData data,
  bool isBackgroundForce,
  bool recordLog = true,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDebug = await DebugLocalStorage().getBackgroundRecord();
  final interceptor = DefaultApiInterceptor.get();
  Logger isolatedLogger = logger;
  recordLog ??= true;
  if (recordLog && isDebug) {
    isolatedLogger =
        Logger.backgroundSync(LoggerInterceptorAdapter(interceptor));
    isolatedLogger.start();
  }
  final isBackground = isBackgroundForce ?? BackgroundHelper.isBackground;
  var hasUpdate = false;
  if (!updateFromNotification.contains(null) &&
      !updateFromNotification.contains(data?.to)) {
    updateFromNotification.add(data?.to);
    try {
      BackgroundHelper.onStartAlarm();
      final future = BackgroundSync()
          .sync(
            isBackground,
            showNotification,
            data,
            isolatedLogger,
            interceptor,
          )
          .timeout(Duration(
              seconds: isBackground ? (Platform.isIOS ? 30 : 60) : 1080));
      hasUpdate = await future;
    } catch (e, s) {
      isolatedLogger.error(e, s);
      print(s);
    }
    updateFromNotification.remove(data?.to);
  }
  BackgroundHelper.onEndAlarm(hasUpdate);
  if (recordLog && isDebug) {
    isolatedLogger?.save();
  }
  await AlarmService.endAlarm(hasUpdate);
  return hasUpdate;
}
