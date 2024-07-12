import 'dart:ui';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/rrule.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:flutter/material.dart';

import 'displayable.dart';


class ViewTask extends Task implements Displayable{
  final Color color;

  const ViewTask({
    required this.color,
    required super.organizer,
    required super.appointment,
    required super.appointmentAccess,
    required super.calendarId,
    required super.userLocalId,
    required super.uid,
    required super.subject,
    required super.description,
    required super.location,
    required super.startTS,
    required super.endTS,
    required super.allDay,
    required super.owner,
    required super.modified,
    required super.recurrenceId,
    required super.lastModified,
    required super.rrule,
    required super.status,
    required super.withDate,
    required super.isPrivate,
    required super.updateStatus,
    required super.synced,
    required super.onceLoaded,
    required super.reminders,
    required super.recurrenceMode,
    required super.recurrenceUntilDate,
    required super.recurrenceWeekDays,
    required super.recurrenceWeeklyFrequency,
    required super.attendees,
  });

  @override
  ViewTask copyWith({
    String? title,
    Color? color,
    DateTime? startDate,
    DateTime? endDate,
    String? organizer,
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
    Set<RemindersOption>? reminders,
    bool? onceLoaded,
    RecurrenceMode? Function()? recurrenceMode,
    DateTime? Function()? recurrenceUntilDate,
    EveryWeekFrequency? Function()? recurrenceWeeklyFrequency,
    Set<DaysOfWeek>? Function()? recurrenceWeekDays,
    Set<Attendee>? attendees,
  }) =>
      ViewTask(
        attendees: attendees ?? this.attendees,
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
        color: color ?? this.color,
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