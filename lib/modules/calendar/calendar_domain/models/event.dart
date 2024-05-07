class Event {
  final int localId;
  final String calendarId;
  final DateTime startTS;
  final DateTime? endTS;
  final String? description;
  final String name;
  final bool isAllDay;

  const Event({
    required this.localId,
    required this.calendarId,
    required this.startTS,
    this.endTS,
    this.description,
    required this.name,
    required this.isAllDay,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          runtimeType == other.runtimeType &&
          localId == other.localId &&
          calendarId == other.calendarId &&
          startTS == other.startTS &&
          endTS == other.endTS &&
          description == other.description &&
          name == other.name &&
          isAllDay == other.isAllDay);

  @override
  int get hashCode =>
      localId.hashCode ^
      calendarId.hashCode ^
      startTS.hashCode ^
      endTS.hashCode ^
      description.hashCode ^
      name.hashCode ^
      isAllDay.hashCode;

  @override
  String toString() {
    return 'Event{' +
        ' localId: $localId,' +
        ' calendarId: $calendarId,' +
        ' startTS: $startTS,' +
        ' endTS: $endTS,' +
        ' description: $description,' +
        ' name: $name,' +
        ' isAllDay: $isAllDay,' +
        '}';
  }

  Event copyWith({
    int? localId,
    String? calendarId,
    DateTime? startTS,
    DateTime? Function()? endTS,
    String? Function()? description,
    String? name,
    bool? isAllDay,
  }) {
    return Event(
      localId: localId ?? this.localId,
      calendarId: calendarId ?? this.calendarId,
      startTS: startTS ?? this.startTS,
      endTS: endTS == null ? this.endTS : endTS(),
      description: description == null ? this.description : description(),
      name: name ?? this.name,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }
}