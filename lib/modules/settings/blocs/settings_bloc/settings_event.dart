import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => null;
}

class InitSettings extends SettingsEvent {
  final User user;

  InitSettings(this.user);

  @override
  List<Object> get props => [user];
}

class SetFrequency extends SettingsEvent {
  final Freq freq;

  SetFrequency(this.freq);

  @override
  List<Object> get props => [freq];
}

class UpdateConnectivity extends SettingsEvent {
  final ConnectivityResult connection;

  UpdateConnectivity(this.connection);

  @override
  List<Object> get props => [connection];
}
