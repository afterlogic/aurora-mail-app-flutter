import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:equatable/equatable.dart';

abstract class SyncSettingsEvent extends Equatable {
  const SyncSettingsEvent();

  @override
  List<Object> get props => null;
}

class InitSyncSettings extends SyncSettingsEvent {
  final User user;

  InitSyncSettings(this.user);

  @override
  List<Object> get props => [user];
}

class SetFrequency extends SyncSettingsEvent {
  final Freq freq;

  SetFrequency(this.freq);

  @override
  List<Object> get props => [freq];
}
