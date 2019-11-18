import 'dart:async';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:moor_flutter/moor_flutter.dart';

import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _methods = new SettingsMethods();

  static bool _isOffline = true;

  static bool get isOffline => _isOffline;

  @override
  SettingsState get initialState => SettingsEmpty();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is InitSettings) yield* _initSyncSettings(event);
    if (event is UpdateConnectivity) yield* _updateConnectivity(event);
    if (event is SetFrequency) yield* _setFrequency(event);
    if (event is SetPeriod) yield* _setPeriod(event);
    if (event is SetDarkTheme) yield* _setDarkTheme(event);
  }

  Stream<SettingsState> _initSyncSettings(InitSettings event) async* {
    yield SettingsLoaded(
      syncFrequency: event.user.syncFreqInSeconds,
      syncPeriod: event.user.syncPeriod,
      darkThemeEnabled: event.user.darkThemeEnabled,
    );
  }

  Stream<SettingsState> _updateConnectivity(UpdateConnectivity event) async* {
    _isOffline = event.connection == ConnectivityResult.none;
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
}
