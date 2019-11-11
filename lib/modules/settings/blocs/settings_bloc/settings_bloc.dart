import 'dart:async';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

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
  }

  Stream<SettingsState> _initSyncSettings(InitSettings event) async* {
    yield SettingsLoaded(frequency: event.user.syncFreqInSeconds);
  }

  Stream<SettingsState> _updateConnectivity(UpdateConnectivity event) async* {
    _isOffline = event.connection == ConnectivityResult.none;
    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(connection: event.connection);
    } else {
      yield SettingsLoaded(connection: event.connection);
    }
  }

  Stream<SettingsState> _setFrequency(SetFrequency event) async* {
    _methods.setFrequency(event.freq);
    final freqInSeconds = SyncFreq.freqToDuration(event.freq).inSeconds;

    if (state is SettingsLoaded) {
      yield (state as SettingsLoaded).copyWith(frequency: freqInSeconds);
    } else {
      yield SettingsLoaded(frequency: freqInSeconds);
    }
  }
}
