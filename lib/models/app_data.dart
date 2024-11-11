import 'package:equatable/equatable.dart';
import 'package:timezone/timezone.dart' as tz;

class AppData extends Equatable {
  final List<String> availableBackendModules;
  final List<String> availableClientModules;
  final tz.Location? location;
  final Map<String, dynamic>? calendarSettings;

  const AppData(
      {required this.availableBackendModules,
      required this.availableClientModules,
      this.calendarSettings,
      this.location});

  AppData copyWith({
    List<String>? availableBackendModules,
    List<String>? availableClientModules,
    tz.Location? Function()? location,
  }) {
    return AppData(
        availableBackendModules:
            availableBackendModules ?? this.availableBackendModules,
        availableClientModules:
            availableClientModules ?? this.availableClientModules,
        location: location != null ? location() : this.location);
  }

  Map<String, dynamic> toMap() {
    return {
      'Core': {
        'AvailableClientModules': this.availableClientModules,
        'AvailableBackendModules': this.availableBackendModules,
        'Timezone': this.location.toString()
      },
      'Calendar': calendarSettings
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      calendarSettings: map['Calendar'] as Map<String, dynamic>,
      location: tz.getLocation(map['Core']['Timezone'] as String),
      availableClientModules:
          (map['Core']['AvailableClientModules'] as List).cast<String>(),
      availableBackendModules:
          (map['Core']['AvailableBackendModules'] as List).cast<String>(),
    );
  }

  @override
  String toString() {
    return ''' availableBackendModules: $availableBackendModules
    availableClientModules: $availableClientModules
    location: $location
    calendarSettings: $calendarSettings''';
  }

  @override
  List<Object?> get props => [
        availableBackendModules,
        availableClientModules,
        location,
        calendarSettings
      ];
}
