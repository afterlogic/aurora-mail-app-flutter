import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => null;
}

class SettingsEmpty extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final int frequency;
  final ConnectivityResult connection;

  const SettingsLoaded({
    this.frequency,
    this.connection = ConnectivityResult.none,
  });

  SettingsLoaded copyWith({
    int frequency,
    ConnectivityResult connection,
  }) {
    return new SettingsLoaded(
      frequency: frequency ?? this.frequency,
      connection: connection ?? this.connection,
    );
  }

  @override
  List<Object> get props => [frequency, connection];
}
