import 'dart:async';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/models/app_data.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/repository/settings_network.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';
import 'package:webmail_api_client/webmail_api_client.dart';
import 'package:timezone/timezone.dart' as tz;

import './bloc.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _methods = AppInjector.instance.settingsMethods();

  static bool isOffline = true;

  SettingsBloc() : super(SettingsEmpty());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is OnResume) await onResume();
    if (event is InitSettings) yield* _initSyncSettings(event);
    if (event is UpdateConnectivity) yield* _updateConnectivity(event);
    if (event is SetFrequency) yield* _setFrequency(event);
    if (event is SetPeriod) yield* _setPeriod(event);
    if (event is SetDarkTheme) yield* _setDarkTheme(event);
    if (event is SetTimeFormat) yield* _setTimeFormat(event);
    if (event is SetLanguage) yield* _setLanguage(event);
  }

  Stream<SettingsState> _initSyncSettings(InitSettings event) async* {
      await AlarmService.setAlarm(
        main.onAlarm,
        ALARM_ID,
        Duration(seconds: event.user.syncFreqInSeconds ?? 300),
      );

      final appSettings = await _methods.getSettingsSharedPrefs();
      final language = await _methods.getLanguage();
      _methods.setUserStorage(event.user);

      if (state is SettingsLoaded) {
        yield (state as SettingsLoaded).copyWith(
            users: Value(event.users),
            syncFrequency: Value(event.user.syncFreqInSeconds ?? 300),
            syncPeriod: Value(event.user.syncPeriod ?? "Period.allTime"),
            darkThemeEnabled: Value(appSettings.isDarkTheme),
            is24: Value(appSettings.is24),
            language: Value(
              Language.fromJson(language),
            ));
      } else {
        yield SettingsLoaded(
          users: event.users,
          syncFrequency: event.user.syncFreqInSeconds,
          syncPeriod: event.user.syncPeriod,
          darkThemeEnabled: appSettings.isDarkTheme,
          is24: appSettings.is24,
          language: Language.fromJson(language),
        );
      }
  }

  Stream<SettingsState> _updateConnectivity(UpdateConnectivity event) async* {
    isOffline = event.connection == ConnectivityResult.none;
    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded)
          .copyWith(connection: Value(event.connection));
    } else {
      final appSettings = await _methods.getSettingsSharedPrefs();
      yield SettingsLoaded(
        connection: event.connection,
        darkThemeEnabled: appSettings.isDarkTheme,
        is24: appSettings.is24,
      );
    }
  }

  Stream<SettingsState> _setFrequency(SetFrequency event) async* {
    await _methods.setFrequency(event.freq);
    final freqInSeconds = SyncFreq.freqToDuration(event.freq).inSeconds;
    await AlarmService.setAlarm(
      main.onAlarm,
      ALARM_ID,
      Duration(seconds: freqInSeconds),
    );
    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded)
          .copyWith(syncFrequency: Value(freqInSeconds));
    } else {
      yield SettingsLoaded(syncFrequency: freqInSeconds);
    }
  }

  Stream<SettingsState> _setPeriod(SetPeriod event) async* {
    await _methods.setPeriod(event.period);

    final periodString = SyncPeriod.periodToDbString(event.period);

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(syncPeriod: Value(periodString));
    } else {
      yield SettingsLoaded(syncPeriod: periodString);
    }
  }

  Stream<SettingsState> _setDarkTheme(SetDarkTheme event) async* {
    await _methods.setDarkTheme(event.darkThemeEnabled);

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded)
          .copyWith(darkThemeEnabled: Value(event.darkThemeEnabled));
    } else {
      yield SettingsLoaded(darkThemeEnabled: event.darkThemeEnabled);
    }
  }

  Stream<SettingsState> _setTimeFormat(SetTimeFormat event) async* {
    await _methods.setTimeFormat(event.is24);

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(is24: Value(event.is24));
    } else {
      yield SettingsLoaded(is24: event.is24);
    }
  }

  Stream<SettingsState> _setLanguage(SetLanguage event) async* {
    await _methods.setLanguage(event.language);

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(language: Value(event.language));
    } else {
      yield SettingsLoaded(language: event.language);
    }
  }

  Future onResume() async {
//    return _methods.clearNotification();
  }

  Future<String?> getLanguage() {
    return _methods.getLanguage();
  }
}
