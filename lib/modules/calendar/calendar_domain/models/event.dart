import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/rrule.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class EventCreationData implements ActivityCreationData{
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
  final Set<Attendee> attendees;

  const EventCreationData(
      {required this.subject,
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
      required this.attendees});

  EventCreationData copyWith({DateTime? startDate, DateTime? endDate}) {
    return EventCreationData(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        subject: subject,
        description: description,
        location: location,
        recurrenceUntilDate: recurrenceUntilDate,
        recurrenceWeeklyFrequency: recurrenceWeeklyFrequency,
        recurrenceWeekDays: recurrenceWeekDays,
        attendees: attendees,
        calendarId: calendarId,
        reminders: reminders,
        allDay: allDay,
        recurrenceMode: recurrenceMode);
  }
}

class Event implements Activity {
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
  final Set<RemindersOption>? reminders;
  final bool synced;
  final bool onceLoaded;
  final RecurrenceMode? recurrenceMode;
  final DateTime? recurrenceUntilDate;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final Set<DaysOfWeek>? recurrenceWeekDays;
  final Set<Attendee> attendees;

  const Event(
      {this.organizer,
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
      required this.attendees});


  factory Event.fill(Event base, Map<String, dynamic>? newData) {
    if (newData == null) {
      return base;
    }

    final rawRrule = newData['rrule'] as Map<String, dynamic>?;

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
            : DateTime.fromMillisecondsSinceEpoch((newData['startTS'] as int) * 1000,
                isUtc: true),
        endTS: (newData['endTS'] as int?) == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch((newData['endTS'] as int) * 1000,
                isUtc: true),
        allDay: (newData['allDay'] as bool?)!,
        owner: (newData['owner'] as String?)!,
        modified: (newData['modified'] as bool?)!,
        recurrenceId: (newData['recurrenceId'] as int?)!,
        lastModified: (newData['lastModified'] as int?)!,
        recurrenceMode: rawRrule == null
            ? RecurrenceMode.never
            : RecurrenceModeX.fromPeriodCode((rawRrule['period'] as int?)!),
        recurrenceUntilDate:
            rawRrule == null || rawRrule['until'] == null || rawRrule['until'] == 0
                ? null
                : DateTime.fromMillisecondsSinceEpoch(
                    (rawRrule['until'] as int) * 1000),
        recurrenceWeeklyFrequency: rawRrule == null
            ? null
            : EveryWeekFrequencyX.fromIntervalCode(
                (rawRrule['interval'] as int?)!),
        recurrenceWeekDays: rawRrule == null
            ? null
            : (rawRrule['byDays'] as List)
                .map((e) => DaysOfWeekX.fromDaysCode(e as String))
                .toSet(),
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
        attendees: (newData['attendees'] as List).map((e) => Attendee.fromMap(e as Map<String, dynamic>)).toSet());
  }

  factory Event.fromDb(ActivityDb entity) {
    return Event(
        description: entity.description,
        location: entity.location,
        calendarId: entity.calendarId,
        startTS: entity.startTS?.toUtc(),
        endTS: entity.endTS?.toUtc(),
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
        updateStatus: entity.updateStatus,
        synced: entity.synced,
        onceLoaded: entity.onceLoaded,
        recurrenceMode: entity.recurrenceMode,
        recurrenceUntilDate: entity.recurrenceUntilDate,
        recurrenceWeeklyFrequency: entity.recurrenceWeeklyFrequency,
        recurrenceWeekDays: entity.recurrenceWeekDaysString != null &&
                entity.recurrenceWeekDaysString!.isNotEmpty
            ? entity.recurrenceWeekDaysString!
                .split(',')
                .map((e) => DaysOfWeekX.fromDaysCode(e))
                .whereNotNull()
                .toSet()
            : {},
        attendees: entity.attendees
                ?.map((e) =>
                    Attendee.fromMap(jsonDecode(e) as Map<String, dynamic>))
                .toSet() ??
            {});
  }

  @override
  ActivityDb toDb() {
    return ActivityDb(
      type: ActivityType.event,
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
        remindersString: reminders?.map((e) => e.toInt).join(','),
        onceLoaded: onceLoaded,
        recurrenceWeekDaysString:
            recurrenceWeekDays?.map((e) => e.byDaysCode).join(','),
        recurrenceWeeklyFrequency: recurrenceWeeklyFrequency,
        recurrenceUntilDate: recurrenceUntilDate,
        recurrenceMode: recurrenceMode,
        attendees: attendees.map((e) => jsonEncode(e.toMap())).toList());
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
          attendees == other.attendees &&
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
      attendees.hashCode ^
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
      Set<Attendee>? attendees,
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
        attendees: attendees ?? this.attendees);
  }

  @override
  Displayable? toDisplayable({required Color color}) {
    try {
      return ViewEvent(
          startDate: this.startTS!,
          endDate: this.endTS!,
          calendarId: this.calendarId,
          title: this.subject!,
          attendees: this.attendees,
          color: color,
          recurrenceId: this.recurrenceId!,
          uid: this.uid,
          userLocalId: this.userLocalId,
          updateStatus: this.updateStatus,
          synced: this.synced,
          onceLoaded: this.onceLoaded,
          organizer: this.organizer,
          appointment: this.appointment,
          appointmentAccess: this.appointmentAccess,
          subject: this.subject,
          description: this.description,
          location: this.location,
          startTS: this.startTS,
          endTS: this.endTS,
          allDay: this.allDay,
          owner: this.owner,
          modified: this.modified,
          lastModified: this.lastModified,
          rrule: this.rrule,
          status: this.status,
          withDate: this.withDate,
          isPrivate: this.isPrivate,
          reminders: this.reminders,
          recurrenceMode: this.recurrenceMode,
          recurrenceUntilDate: this.recurrenceUntilDate,
          recurrenceWeekDays: this.recurrenceWeekDays,
          recurrenceWeeklyFrequency: this.recurrenceWeeklyFrequency);
    } catch (e, s) {
      return null;
    }
  }
}