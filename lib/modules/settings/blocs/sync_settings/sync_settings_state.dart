import 'package:equatable/equatable.dart';

abstract class SyncSettingsState extends Equatable {
  const SyncSettingsState();
}

class InitialSyncSettingsState extends SyncSettingsState {
  @override
  List<Object> get props => [];
}
