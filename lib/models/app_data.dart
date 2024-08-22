import 'package:timezone/timezone.dart' as tz;

class AppData {
  final List<String> availableModules;
  final tz.Location? location;

  const AppData({required this.availableModules, this.location});

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
      'AvailableClientModules': this.availableModules,
      'Timezone': this.location.toString()
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      location: tz.getLocation(map['Timezone'] as String),
      availableModules: (map['AvailableClientModules'] as List).cast<String>(),
    );
  }
}
