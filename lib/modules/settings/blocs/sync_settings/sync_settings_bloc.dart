import 'dart:async';

import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class SyncSettingsBloc extends Bloc<SyncSettingsEvent, SyncSettingsState> {
  SyncDuration syncDuration;

  @override
  SyncSettingsState get initialState => InitialSyncSettingsState();

  @override
  Stream<SyncSettingsState> mapEventToState(
    SyncSettingsEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
