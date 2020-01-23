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
  final List<User> users;

  const InitSettings(this.user, this.users);

  @override
  List<Object> get props => [user];
}

class SetFrequency extends SettingsEvent {
  final Freq freq;

  const SetFrequency(this.freq);

  @override
  List<Object> get props => [freq];
}

class SetPeriod extends SettingsEvent {
  final Period period;

  const SetPeriod(this.period);

  @override
  List<Object> get props => [period];
}

class SetDarkTheme extends SettingsEvent {
  final bool darkThemeEnabled;

  const SetDarkTheme(this.darkThemeEnabled);

  @override
  List<Object> get props => [darkThemeEnabled];
}

class SetTimeFormat extends SettingsEvent {
  final bool is24;

  const SetTimeFormat(this.is24);

  @override
  List<Object> get props => [is24];
}

class SetLanguage extends SettingsEvent {
  final Language language;

  const SetLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class UpdateConnectivity extends SettingsEvent {
  final ConnectivityResult connection;

  const UpdateConnectivity(this.connection);

  @override
  List<Object> get props => [connection];
}

class OnResume extends SettingsEvent {
  @override
  final List<Object> props = [DateTime.now().millisecondsSinceEpoch];
}
