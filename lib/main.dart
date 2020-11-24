import 'dart:convert';
import 'dart:io';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/bloc_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/logger/logger_view.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:aurora_mail/shared_ui/restart_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webmail_api_client/webmail_api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'background/background_helper.dart';
import 'background/background_sync.dart';
import 'logger/logger.dart';
import 'modules/app_screen.dart';
import 'modules/settings/screens/debug/debug_local_storage.dart';
import 'notification/notification_manager.dart';

void main() async {
  AppInjector.create();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true) ;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // ignore: invalid_use_of_protected_member
  DBInstances.appDB.connection.executor.ensureOpen();
  WidgetsFlutterBinding.ensureInitialized();
  DebugLocalStorage().getDebug().then((value) {
    if (value) {
      logger.enable = true;
    }
  });
  DebugLocalStorage().getIsRun().then((value) {
    if (value) {
      logger.start();
    }
  });
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
  NotificationManager.instance;
  AlarmService.init();
  AlarmService.onAlarm(onAlarm, ALARM_ID);
  AlarmService.onNotification(messageHandler);
  BlocSupervisor.delegate = BlocLogger();
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
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDebug = await DebugLocalStorage().getBackgroundRecord();
  ApiInterceptor interceptor;
  Logger isolatedLogger = logger;

  if (isDebug) {
    interceptor = ApiInterceptor(true);
    isolatedLogger = Logger.backgroundSync(interceptor);
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
          .timeout(
              Duration(seconds: isBackground ? (Platform.isIOS ? 30 : 60) : 1080));
      hasUpdate = await future;
    } catch (e, s) {
      isolatedLogger.error(e, s);
      print(s);
    }
    updateFromNotification.remove(data?.to);
  }
  BackgroundHelper.onEndAlarm(hasUpdate);
  if (isDebug) {
    isolatedLogger?.save();
  }
  await AlarmService.endAlarm(hasUpdate);
  return hasUpdate;
}
