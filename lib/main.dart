

import 'dart:async';
import 'dart:io';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/bloc_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/notification/models/notification_data.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest_all.dart' as tz;

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

  if (BuildProperty.enableAppCheck) {
    const appCheckDebugToken =
        String.fromEnvironment('FIREBASE_APP_CHECK_DEBUG_TOKEN');
    debugPrint('!!! Dart FIREBASE_APP_CHECK_DEBUG_TOKEN: $appCheckDebugToken');
    final isDebugBuild = appCheckDebugToken.isNotEmpty;
    await FirebaseAppCheck.instance.activate(
      androidProvider:
          isDebugBuild ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: isDebugBuild
          ? AppleProvider.debug
          : AppleProvider.appAttestWithDeviceCheckFallback,
    );
  }

  if (!kDebugMode) {
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterError(details, fatal: true);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  AppInjector.create();

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

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runZonedGuarded<void>(
    () => runApp(
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
    (error, stack) {
      debugPrint('!!! ZoneError: $error Stack: $stack');
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
}

Set<String?> updateFromNotification = {};

@pragma('vm:entry-point')
Future<bool> onAlarm({
  bool showNotification = true,
  NotificationData? data,
  bool? isBackgroundForce,
  bool recordLog = true,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // onAlarm can run in a fresh background isolate that never executes main(),
  // so LoggerSetting.init() (which sets the real packageName used for the
  // logs directory) may not have run yet. Without this, logs silently get
  // written under "Logs_packageName" instead of the real app-specific folder.
  LoggerSetting.init(LoggerSetting(
    packageName: BuildProperty.packageName,
    defaultInterceptor: DefaultLoggerInterceptorAdapter(),
  ));
  final isDebug = await DebugLocalStorage().getBackgroundRecord();
  final interceptor = DefaultApiInterceptor.get();
  Logger isolatedLogger = logger;
  recordLog ??= true;
  if (recordLog && isDebug) {
    isolatedLogger =
        Logger.backgroundSync(LoggerInterceptorAdapter(interceptor!));
    isolatedLogger.start();
  }
  final isBackground = isBackgroundForce ?? BackgroundHelper.isBackground;
  // Classify which of the 4 known onAlarm trigger scenarios this run is, so
  // the debug log (Settings -> Debug -> Record log in background) can be
  // used to tell them apart instead of guessing from indirect evidence:
  //   1 = app was killed, this is a fresh isolate that never ran main()
  //   2 = app process alive but backgrounded
  //   3 = app process alive and in the foreground
  //   4 = triggered by an incoming push message (messageHandler), not the
  //       periodic AlarmManager alarm at all
  // See docs/background-sync-new-mail-notification-investigation.md.
  final isColdStart = !BackgroundHelper.appIsRunning;
  final scenario = data != null
      ? 4
      : isColdStart
          ? 1
          : isBackground
              ? 2
              : 3;
  isolatedLogger.log("MAIL_SYNC: scenario=$scenario "
      "(coldStart=$isColdStart, triggeredByPush=${data != null}, "
      "isBackground=$isBackground, isBackgroundForce=$isBackgroundForce, "
      "recordLog=$recordLog, showNotification=$showNotification, "
      "notificationTo=${data?.to})");
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
  // TEMP: delay to keep the foreground sync notification visible long enough
  // to capture on video for the Play Console FOREGROUND_SERVICE_DATA_SYNC demo.
  // Revert after recording.
  await Future.delayed(Duration(seconds: 5));
  await AlarmService.endAlarm(hasUpdate);
  return hasUpdate;
}
