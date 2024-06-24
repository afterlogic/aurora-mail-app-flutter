import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/recurrence_mode_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/reminders_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/weekly_recurrence_select_dialog.dart';
import 'package:collection/collection.dart';

class EventCreationData {
  final String subject;
  final String? description;
  final String? location;
  final String calendarId;
  final DateTime startDate;
  final DateTime endDate;
  final Set<RemindersOption> reminders;
  final bool? allDay;
  final RecurrenceMode recurrenceMode;
  final DateTime? recurrenceUntilDate;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final Set<DaysOfWeek>? recurrenceWeekDays;

  const EventCreationData({
    required this.subject,
    this.description,
    this.location,
    required this.calendarId,
    required this.startDate,
    required this.endDate,
    required this.reminders,
    required this.allDay,
    required this.recurrenceMode,
    this.recurrenceUntilDate,
    this.recurrenceWeeklyFrequency,
    this.recurrenceWeekDays,
  });
}

class Event extends EventBase {
  final String? organizer;
  final bool? appointment;
  final int? appointmentAccess;
  final String calendarId;
  final int userLocalId;
  final String uid;
  final String? subject;
  final String? description;
  final String? location;
  final DateTime? startTS;
  final DateTime? endTS;
  final bool? allDay;
  final String? owner;
  final bool? modified;
  final int? recurrenceId;
  final int? lastModified;
  final Rrule? rrule;
  final bool? status;
  final bool? withDate;
  final bool? isPrivate;
  final UpdateStatus updateStatus;
  final Set<RemindersOption> reminders;
  final bool synced;
  final bool onceLoaded;
  final RecurrenceMode? recurrenceMode;
  final DateTime? recurrenceUntilDate;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final Set<DaysOfWeek>? recurrenceWeekDays;

  const Event({
    this.organizer,
    this.appointment,
    this.appointmentAccess,
    required this.calendarId,
    required this.userLocalId,
    required this.uid,
    this.subject,
    this.description,
    this.location,
    this.startTS,
    this.endTS,
    this.allDay,
    this.owner,
    this.modified,
    this.recurrenceId,
    this.lastModified,
    this.rrule,
    this.status,
    this.withDate,
    this.isPrivate,
    required this.updateStatus,
    required this.reminders,
    required this.synced,
    required this.onceLoaded,
    this.recurrenceMode,
    this.recurrenceUntilDate,
    this.recurrenceWeeklyFrequency,
    this.recurrenceWeekDays,
  }) : super(
            uid: uid,
            updateStatus: updateStatus,
            userLocalId: userLocalId,
            calendarId: calendarId);

  factory Event.fill(Event base, Map<String, dynamic>? newData) {
    if (newData == null) {
      return base;
    }
    return Event(
      ///All timestamps should be in seconds
      organizer: newData['organizer'] as String? ?? '',
      appointment: (newData['appointment'] as bool?)!,
      appointmentAccess: (newData['appointmentAccess'] as int?)!,
      calendarId: (newData['calendarId'] as String?)!,
      userLocalId: base.userLocalId,
      uid: (newData['uid'] as String?)!,
      subject: (newData['subject'] as String?)!,
      description: (newData['description'] as String?) ?? '',
      location: (newData['location'] as String?) ?? '',
      startTS: (newData['startTS'] as int?) == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              (newData['startTS'] as int) * 1000),
      endTS: (newData['endTS'] as int?) == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              (newData['endTS'] as int) * 1000),
      allDay: (newData['allDay'] as bool?)!,
      owner: (newData['owner'] as String?)!,
      modified: (newData['modified'] as bool?)!,
      recurrenceId: (newData['recurrenceId'] as int?)!,
      lastModified: (newData['lastModified'] as int?)!,
      rrule: null,
      status: (newData['status'] as bool?)!,
      withDate: (newData['withDate'] as bool?)!,
      isPrivate: (newData['isPrivate'] as bool?)!,
      updateStatus: base.updateStatus,
      synced: true,
      onceLoaded: true,
      reminders: (newData['alarms'] as List?)
              ?.map((e) => RemindersIntMapper.fromInt(e as int))
              .whereNotNull()
              .toSet() ??
          {},
    );
  }

  factory Event.fromDb(EventDb entity) {
    return Event(
        description: entity.description,
        location: entity.location,
        calendarId: entity.calendarId,
        startTS: entity.startTS,
        organizer: entity.organizer,
        appointment: entity.appointment,
        appointmentAccess: entity.appointmentAccess,
        userLocalId: entity.userLocalId,
        uid: entity.uid,
        allDay: entity.allDay,
        owner: entity.owner,
        modified: entity.modified,
        recurrenceId: entity.recurrenceId,
        lastModified: entity.lastModified,
        status: entity.status,
        withDate: entity.withDate,
        isPrivate: entity.isPrivate,
        reminders:
            entity.remindersString != null && entity.remindersString!.isNotEmpty
                ? entity.remindersString!
                    .split(',')
                    .map((e) => RemindersIntMapper.fromInt(int.parse(e)))
                    .whereNotNull()
                    .toSet()
                : {},
        // rrule: null,
        subject: entity.subject,
        endTS: entity.endTS,
        updateStatus: entity.updateStatus,
        synced: entity.synced,
        onceLoaded: entity.onceLoaded);
  }

  @override
  EventDb toDb() {
    return EventDb(
        description: description,
        location: location,
        calendarId: calendarId,
        startTS: startTS,
        organizer: organizer,
        appointment: appointment,
        appointmentAccess: appointmentAccess,
        userLocalId: userLocalId,
        uid: uid,
        allDay: allDay,
        owner: owner,
        modified: modified,
        recurrenceId: recurrenceId,
        lastModified: lastModified,
        status: status,
        withDate: withDate,
        isPrivate: isPrivate,
        // rrule: null,
        subject: subject,
        endTS: endTS,
        updateStatus: updateStatus,
        synced: synced,
        remindersString: reminders.map((e) => e.toInt).join(','),
        onceLoaded: onceLoaded);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          runtimeType == other.runtimeType &&
          organizer == other.organizer &&
          appointment == other.appointment &&
          appointmentAccess == other.appointmentAccess &&
          calendarId == other.calendarId &&
          userLocalId == other.userLocalId &&
          uid == other.uid &&
          subject == other.subject &&
          description == other.description &&
          location == other.location &&
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
          isPrivate == other.isPrivate &&
          updateStatus == other.updateStatus &&
          synced == other.synced &&
          reminders == other.reminders &&
          onceLoaded == other.onceLoaded &&
          recurrenceMode == other.recurrenceMode &&
          recurrenceUntilDate == other.recurrenceUntilDate &&
          recurrenceWeekDays == other.recurrenceWeekDays &&
          recurrenceWeeklyFrequency == other.recurrenceWeeklyFrequency);

  @override
  int get hashCode =>
      organizer.hashCode ^
      appointment.hashCode ^
      appointmentAccess.hashCode ^
      calendarId.hashCode ^
      userLocalId.hashCode ^
      uid.hashCode ^
      subject.hashCode ^
      description.hashCode ^
      location.hashCode ^
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
      isPrivate.hashCode ^
      updateStatus.hashCode ^
      synced.hashCode ^
      onceLoaded.hashCode ^
      reminders.hashCode ^
      recurrenceMode.hashCode ^
      recurrenceWeeklyFrequency.hashCode ^
      recurrenceWeekDays.hashCode ^
      recurrenceUntilDate.hashCode;

  @override
  String toString() {
    return 'Event{' +
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
        ' updateStatus: $updateStatus,' +
        ' synced: $synced,' +
        ' onceLoaded: $onceLoaded,' +
        '}';
  }

  Event copyWith(
      {String? organizer,
      bool? appointment,
      int? appointmentAccess,
      String? calendarId,
      int? userLocalId,
      String? uid,
      String? subject,
      String? description,
      String? location,
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
      UpdateStatus? updateStatus,
      bool? synced,
      bool? onceLoaded,
      RecurrenceMode? Function()? recurrenceMode,
      DateTime? Function()? recurrenceUntilDate,
      EveryWeekFrequency? Function()? recurrenceWeeklyFrequency,
      Set<DaysOfWeek>? Function()? recurrenceWeekDays,
      Set<RemindersOption>? reminders}) {
    return Event(
      organizer: organizer ?? this.organizer,
      appointment: appointment ?? this.appointment,
      appointmentAccess: appointmentAccess ?? this.appointmentAccess,
      calendarId: calendarId ?? this.calendarId,
      userLocalId: userLocalId ?? this.userLocalId,
      uid: uid ?? this.uid,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      location: location ?? this.location,
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
      updateStatus: updateStatus ?? this.updateStatus,
      synced: synced ?? this.synced,
      onceLoaded: onceLoaded ?? this.onceLoaded,
      reminders: reminders ?? this.reminders,
      recurrenceMode:
          recurrenceMode == null ? this.recurrenceMode : recurrenceMode(),
      recurrenceUntilDate: recurrenceUntilDate == null
          ? this.recurrenceUntilDate
          : recurrenceUntilDate(),
      recurrenceWeekDays: recurrenceWeekDays == null
          ? this.recurrenceWeekDays
          : recurrenceWeekDays(),
      recurrenceWeeklyFrequency: recurrenceWeeklyFrequency == null
          ? this.recurrenceWeeklyFrequency
          : recurrenceWeeklyFrequency(),
    );
  }
}

enum RemindersOption {
  min5,
  min10,
  min15,
  min30,
  hours1,
  hours2,
  hours3,
}

extension RemindersIntMapper on RemindersOption {
  static RemindersOption? fromInt(int value) {
    switch (value) {
      case 5:
        return RemindersOption.min5;
      case 10:
        return RemindersOption.min10;
      case 15:
        return RemindersOption.min15;
      case 30:
        return RemindersOption.min30;
      case 60:
        return RemindersOption.hours1;
      case 120:
        return RemindersOption.hours2;
      case 180:
        return RemindersOption.hours3;
      default:
        return null;
    }
  }

  int get toInt {
    switch (this) {
      case RemindersOption.min5:
        return 5;
      case RemindersOption.min10:
        return 10;
      case RemindersOption.min15:
        return 15;
      case RemindersOption.min30:
        return 30;
      case RemindersOption.hours1:
        return 60;
      case RemindersOption.hours2:
        return 120;
      case RemindersOption.hours3:
        return 180;
    }
  }
}

extension RemindersOptionString on RemindersOption {
  String get buildString {
    switch (this) {
      case RemindersOption.min5:
        return '5 minutes';
      case RemindersOption.min10:
        return '10 minutes';
      case RemindersOption.min15:
        return '15 minutes';
      case RemindersOption.min30:
        return '30 minutes';
      case RemindersOption.hours1:
        return '1 hours';
      case RemindersOption.hours2:
        return '2 hours';
      case RemindersOption.hours3:
        return '3 hours';
    }
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
