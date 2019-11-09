import 'dart:async';

import 'package:aurora_mail/modules/settings/blocs/sync_settings/sync_settings_methods.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class SyncSettingsBloc extends Bloc<SyncSettingsEvent, SyncSettingsState> {
  SyncFreq syncDuration;

  final _methods = new SyncSettingsMethods();
  


  @override
  SyncSettingsState get initialState => InitialSyncSettingsState(300);

  @override
  Stream<SyncSettingsState> mapEventToState(
    SyncSettingsEvent event,
  ) async* {
    if (event is InitSyncSettings) yield* _initSyncSettings(event);
    if (event is SetFrequency) yield* _setFrequency(event);
  }

  Stream<SyncSettingsState> _initSyncSettings(InitSyncSettings event) async* {
    print("VO: freqInSeconds: ${event.user.syncFreqInSeconds}");
    yield InitialSyncSettingsState(event.user.syncFreqInSeconds);
  }

  Stream<SyncSettingsState> _setFrequency(SetFrequency event) async* {
    _methods.setFrequency(event.freq);
    final freqInSeconds = SyncFreq.freqToDuration(event.freq).inSeconds;
    print("VO: freqInSeconds: ${freqInSeconds}");

    yield InitialSyncSettingsState(freqInSeconds);
  }
}
