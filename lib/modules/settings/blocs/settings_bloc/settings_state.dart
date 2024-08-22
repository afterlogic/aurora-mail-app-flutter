//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/app_data.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => null;
}

class SettingsEmpty extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final List<User> users;
  final int syncFrequency;
  final String syncPeriod;
  final bool darkThemeEnabled;
  final bool is24;
  final Language language;
  final ConnectivityResult connection;
  final AppData settings;

  SettingsLoaded({
    this.users,
    this.syncFrequency,
    this.syncPeriod,
    this.darkThemeEnabled,
    this.is24,
    this.language,
    this.connection = ConnectivityResult.none,
    this.settings,
  });

  SettingsLoaded copyWith({
    Value<List<User>> users,
    Value<int> syncFrequency,
    Value<String> syncPeriod,
    Value<bool> darkThemeEnabled,
    Value<bool> is24,
    Value<Language> language,
    Value<ConnectivityResult> connection,
    AppData Function() settings,
  }) {
    return new SettingsLoaded(
        users: users != null ? users.value : this.users,
        syncFrequency:
            syncFrequency != null ? syncFrequency.value : this.syncFrequency,
        syncPeriod: syncPeriod != null ? syncPeriod.value : this.syncPeriod,
        darkThemeEnabled: darkThemeEnabled != null
            ? darkThemeEnabled.value
            : this.darkThemeEnabled,
        is24: is24 != null ? is24.value : this.is24,
        language: language != null ? language.value : this.language,
        connection: connection != null ? connection.value : this.connection,
        settings: settings != null ? settings() : this.settings);
  }

  @override
  List<Object> get props => [
        syncFrequency,
        syncPeriod,
        darkThemeEnabled,
        is24,
        language,
        connection,
        settings
      ];
}
