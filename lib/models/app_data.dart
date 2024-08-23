import 'package:timezone/timezone.dart' as tz;

class AppData {
  final List<String> availableModules;
  final tz.Location? location;
  final Map<String, dynamic>? calendarSettings;

  const AppData(
      {required this.availableModules, this.calendarSettings, this.location});

  AppData copyWith({
    List<String>? availableModules,
    tz.Location? Function()? location,
  }) {
    return AppData(
        availableModules: availableModules ?? this.availableModules,
        location: location != null ? location() : this.location);
  }

  Map<String, dynamic> toMap() {
    return {
      'Core': {
        'AvailableClientModules': this.availableModules,
        'Timezone': this.location.toString()
      },
      'Calendar': calendarSettings
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      calendarSettings: map['Calendar'] as Map<String, dynamic>,
      location: tz.getLocation(map['Core']['Timezone'] as String),
      availableModules:
          (map['Core']['AvailableBackendModules'] as List).cast<String>(),
    );
  }
}
