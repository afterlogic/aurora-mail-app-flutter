//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/app_data.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';
import 'package:timezone/timezone.dart' as tz;

enum InitialSettingsLoadingStatus {
  loading,
  loaded,
}

extension InitialSettingsLoadingStatusX on InitialSettingsLoadingStatus {
  bool get isLoaded => this == InitialSettingsLoadingStatus.loaded;
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => null;
}

class SettingsEmpty extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final InitialSettingsLoadingStatus initialSettingsLoadingStatus;
  final List<User> users;
  final int syncFrequency;
  final String syncPeriod;
  final bool darkThemeEnabled;
  final bool is24;
  final Language language;
  final ConnectivityResult connection;
  final AppData settings;

  SettingsLoaded({
    this.initialSettingsLoadingStatus = InitialSettingsLoadingStatus.loading,
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
    InitialSettingsLoadingStatus initialSettingsLoadingStatus,
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
        initialSettingsLoadingStatus:
            initialSettingsLoadingStatus ?? this.initialSettingsLoadingStatus,
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
        initialSettingsLoadingStatus,
        syncFrequency,
        syncPeriod,
        darkThemeEnabled,
        is24,
        language,
        connection,
        settings
      ];
}
