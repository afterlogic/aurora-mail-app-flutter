import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => null;
}

class SettingsEmpty extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final int syncFrequency;
  final String syncPeriod;
  final bool darkThemeEnabled;
  final Language language;
  final ConnectivityResult connection;

  const SettingsLoaded({
    this.syncFrequency,
    this.syncPeriod,
    this.darkThemeEnabled = false,
    this.language,
    this.connection = ConnectivityResult.none,
  });

  SettingsLoaded copyWith({
    Value<int> syncFrequency,
    Value<String> syncPeriod,
    Value<bool> darkThemeEnabled,
    Value<Language> language,
    Value<ConnectivityResult> connection,
  }) {
    return new SettingsLoaded(
      syncFrequency:
          syncFrequency != null ? syncFrequency.value : this.syncFrequency,
      syncPeriod: syncPeriod != null ? syncPeriod.value : this.syncPeriod,
      darkThemeEnabled: darkThemeEnabled != null
          ? darkThemeEnabled.value
          : this.darkThemeEnabled,
      language: language != null ? language.value : this.language,
      connection: connection != null ? connection.value : this.connection,
    );
  }

  @override
  List<Object> get props => [
        syncFrequency,
        syncPeriod,
        darkThemeEnabled,
        language,
        connection,
      ];
}
