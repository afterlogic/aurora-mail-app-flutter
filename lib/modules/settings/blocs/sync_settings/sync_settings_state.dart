import 'package:equatable/equatable.dart';

abstract class SyncSettingsState extends Equatable {
  const SyncSettingsState();
}

class InitialSyncSettingsState extends SyncSettingsState {
  final int frequency;

  const InitialSyncSettingsState(this.frequency);

  @override
  List<Object> get props => [];
}
