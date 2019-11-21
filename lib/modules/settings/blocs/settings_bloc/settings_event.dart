import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
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

class SetPeriod extends SettingsEvent {
  final Period period;

  SetPeriod(this.period);

  @override
  List<Object> get props => [period];
}

class SetDarkTheme extends SettingsEvent {
  final bool darkThemeEnabled;

  SetDarkTheme(this.darkThemeEnabled);

  @override
  List<Object> get props => [darkThemeEnabled];
}

class SetLanguage extends SettingsEvent {
  final Language language;

  SetLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class UpdateConnectivity extends SettingsEvent {
  final ConnectivityResult connection;

  UpdateConnectivity(this.connection);

  @override
  List<Object> get props => [connection];
}
