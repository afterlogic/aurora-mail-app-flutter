class Event {
  final String organizer;
  final bool appointment;
  final int appointmentAccess;
  final String calendarId;
  final String id;
  final String uid;
  final String? subject;
  final String? description;
  final DateTime startTS;
  final DateTime? endTS;
  final bool allDay;
  final String owner;
  final bool modified;
  final int recurrenceId;
  final int lastModified;
  final Rrule? rrule;
  final bool status;
  final bool withDate;
  final bool isPrivate;

  const Event({
    required this.organizer,
    required this.appointment,
    required this.appointmentAccess,
    required this.calendarId,
    required this.id,
    required this.uid,
    this.subject,
    this.description,
    required this.startTS,
    this.endTS,
    required this.allDay,
    required this.owner,
    required this.modified,
    required this.recurrenceId,
    required this.lastModified,
    this.rrule,
    required this.status,
    required this.withDate,
    required this.isPrivate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          runtimeType == other.runtimeType &&
          organizer == other.organizer &&
          appointment == other.appointment &&
          appointmentAccess == other.appointmentAccess &&
          calendarId == other.calendarId &&
          id == other.id &&
          uid == other.uid &&
          subject == other.subject &&
          description == other.description &&
          startTS == other.startTS &&
          endTS == other.endTS &&
          allDay == other.allDay &&
          owner == other.owner &&
          modified == other.modified &&
          recurrenceId == other.recurrenceId &&
          lastModified == other.lastModified &&
          rrule == other.rrule &&
          status == other.status &&
          withDate == other.withDate &&
          isPrivate == other.isPrivate);

  @override
  int get hashCode =>
      organizer.hashCode ^
      appointment.hashCode ^
      appointmentAccess.hashCode ^
      calendarId.hashCode ^
      id.hashCode ^
      uid.hashCode ^
      subject.hashCode ^
      description.hashCode ^
      startTS.hashCode ^
      endTS.hashCode ^
      allDay.hashCode ^
      owner.hashCode ^
      modified.hashCode ^
      recurrenceId.hashCode ^
      lastModified.hashCode ^
      rrule.hashCode ^
      status.hashCode ^
      withDate.hashCode ^
      isPrivate.hashCode;

  @override
  String toString() {
    return 'Event{' +
        ' organizer: $organizer,' +
        ' appointment: $appointment,' +
        ' appointmentAccess: $appointmentAccess,' +
        ' calendarId: $calendarId,' +
        ' id: $id,' +
        ' uid: $uid,' +
        ' subject: $subject,' +
        ' description: $description,' +
        ' startTS: $startTS,' +
        ' endTS: $endTS,' +
        ' allDay: $allDay,' +
        ' owner: $owner,' +
        ' modified: $modified,' +
        ' recurrenceId: $recurrenceId,' +
        ' lastModified: $lastModified,' +
        ' rrule: $rrule,' +
        ' status: $status,' +
        ' withDate: $withDate,' +
        ' isPrivate: $isPrivate,' +
        '}';
  }

  Event copyWith({
    String? organizer,
    bool? appointment,
    int? appointmentAccess,
    String? calendarId,
    String? id,
    String? uid,
    String? subject,
    String? description,
    DateTime? startTS,
    DateTime? endTS,
    bool? allDay,
    String? owner,
    bool? modified,
    int? recurrenceId,
    int? lastModified,
    Rrule? rrule,
    bool? status,
    bool? withDate,
    bool? isPrivate,
  }) {
    return Event(
      organizer: organizer ?? this.organizer,
      appointment: appointment ?? this.appointment,
      appointmentAccess: appointmentAccess ?? this.appointmentAccess,
      calendarId: calendarId ?? this.calendarId,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      startTS: startTS ?? this.startTS,
      endTS: endTS ?? this.endTS,
      allDay: allDay ?? this.allDay,
      owner: owner ?? this.owner,
      modified: modified ?? this.modified,
      recurrenceId: recurrenceId ?? this.recurrenceId,
      lastModified: lastModified ?? this.lastModified,
      rrule: rrule ?? this.rrule,
      status: status ?? this.status,
      withDate: withDate ?? this.withDate,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}

class Rrule {
  final int startBase;
  final int? endBase;
  final int? period;
  final String? interval;
  final int? end;
  final String? until;

  const Rrule({
    required this.startBase,
    this.endBase,
    this.period,
    this.interval,
    this.end,
    this.until,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rrule &&
          runtimeType == other.runtimeType &&
          startBase == other.startBase &&
          endBase == other.endBase &&
          period == other.period &&
          interval == other.interval &&
          end == other.end &&
          until == other.until);

  @override
  int get hashCode =>
      startBase.hashCode ^
      endBase.hashCode ^
      period.hashCode ^
      interval.hashCode ^
      end.hashCode ^
      until.hashCode;

  @override
  String toString() {
    return 'Rrule{' +
        ' startBase: $startBase,' +
        ' endBase: $endBase,' +
        ' period: $period,' +
        ' interval: $interval,' +
        ' end: $end,' +
        ' until: $until,' +
        '}';
  }

  Rrule copyWith({
    int? startBase,
    int? endBase,
    int? period,
    String? interval,
    int? end,
    String? until,
  }) {
    return Rrule(
      startBase: startBase ?? this.startBase,
      endBase: endBase ?? this.endBase,
      period: period ?? this.period,
      interval: interval ?? this.interval,
      end: end ?? this.end,
      until: until ?? this.until,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startBase': this.startBase,
      'endBase': this.endBase,
      'period': this.period,
      'interval': this.interval,
      'end': this.end,
      'until': this.until,
    };
  }

  factory Rrule.fromMap(Map<String, dynamic> map) {
    return Rrule(
      startBase: map['startBase'] as int,
      endBase: map['endBase'] as int,
      period: map['period'] as int,
      interval: map['interval'] as String,
      end: map['end'] as int,
      until: map['until'] as String,
    );
  }
}
