import 'dart:async';

import 'package:aurora_mail/background/alarm/alarm.dart';
import 'package:aurora_mail/main.dart' as main;
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:moor_flutter/moor_flutter.dart';

import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _methods = new SettingsMethods();

  static bool isOffline = true;

  @override
  SettingsState get initialState => SettingsEmpty();

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
    await Alarm.periodic(
      Duration(seconds: event.user.syncFreqInSeconds),
      main.onAlarm,
    );

    final appSettings = await _methods.getSettingsSharedPrefs();

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(
          users: Value(event.users),
          syncFrequency: Value(event.user.syncFreqInSeconds),
          syncPeriod: Value(event.user.syncPeriod),
          darkThemeEnabled: Value(appSettings.isDarkTheme),
          is24: Value(appSettings.is24),
          language: Value(
            Language.fromJson(event.user.language),
          ));
    } else {
      yield SettingsLoaded(
        users: event.users,
        syncFrequency: event.user.syncFreqInSeconds,
        syncPeriod: event.user.syncPeriod,
        darkThemeEnabled: appSettings.isDarkTheme,
        is24: appSettings.is24,
        language: Language.fromJson(event.user.language),
      );
    }
  }

  Stream<SettingsState> _updateConnectivity(UpdateConnectivity event) async* {
    isOffline = event.connection == ConnectivityResult.none;
    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded)
          .copyWith(connection: Value(event.connection));
    } else {
      yield SettingsLoaded(connection: event.connection);
    }
  }

  Stream<SettingsState> _setFrequency(SetFrequency event) async* {
    await _methods.setFrequency(event.freq);
    final freqInSeconds = SyncFreq.freqToDuration(event.freq).inSeconds;
    await Alarm.periodic(
      Duration(seconds: freqInSeconds),
      main.onAlarm,
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
      yield (state as SettingsLoaded).copyWith(darkThemeEnabled: Value(event.darkThemeEnabled));
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
}
