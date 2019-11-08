import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:equatable/equatable.dart';

abstract class SyncSettingsEvent extends Equatable {
  const SyncSettingsEvent();

  @override
  List<Object> get props => null;
}

class SetFrequency extends SyncSettingsEvent {
  final SyncDuration freq;

  SetFrequency(this.freq);

  @override
  List<Object> get props => [freq];
}
