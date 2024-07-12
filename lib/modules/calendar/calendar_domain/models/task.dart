import 'dart:convert';
import 'dart:ui';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/rrule.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';

class TaskCreationData implements ActivityCreationData{
  final String subject;
  final String? description;
  final String? location;
  final String calendarId;
  final DateTime? startDate;
  final DateTime? endDate;
  final Set<RemindersOption> reminders;
  final bool? allDay;
  final RecurrenceMode recurrenceMode;
  final DateTime? recurrenceUntilDate;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final Set<DaysOfWeek>? recurrenceWeekDays;
  final Set<Attendee> attendees;

  const TaskCreationData(
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

  TaskCreationData copyWith({DateTime? startDate, DateTime? endDate}) {
    return TaskCreationData(
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


class Task implements Activity {
  final String uid;
  final UpdateStatus updateStatus;
  final int userLocalId;
  final String calendarId;
  final bool? allDay;
  final bool? appointment;
  final int? appointmentAccess;
  final Set<Attendee>? attendees;
  final String? description;
  final DateTime? endTS;
  final bool? isPrivate;
  final int? lastModified;
  final String? location;
  final bool? modified;
  final bool onceLoaded;
  final String? organizer;
  final String? owner;
  final int? recurrenceId;
  final RecurrenceMode? recurrenceMode;
  final DateTime? recurrenceUntilDate;
  final Set<DaysOfWeek>? recurrenceWeekDays;
  final EveryWeekFrequency? recurrenceWeeklyFrequency;
  final Set<RemindersOption>? reminders;
  final Rrule? rrule;
  final DateTime? startTS;
  final bool? status;
  final String? subject;
  final bool synced;
  final bool? withDate;

  const Task({
    required this.uid,
    required this.updateStatus,
    required this.userLocalId,
    required this.calendarId,
    required this.allDay,
    this.appointment,
    this.appointmentAccess,
    this.attendees,
    this.description,
    this.endTS,
    this.isPrivate,
    this.lastModified,
    this.location,
    this.modified,
    required this.onceLoaded,
    this.organizer,
    this.owner,
    this.recurrenceId,
    this.recurrenceMode,
    this.recurrenceUntilDate,
    this.recurrenceWeekDays,
    this.recurrenceWeeklyFrequency,
    this.reminders,
    this.rrule,
    this.startTS,
    this.status,
    this.subject,
    required this.synced,
    this.withDate,
  });

  @override
  ActivityDb toDb() {
    return ActivityDb(
        type: ActivityType.task,
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
        attendees: attendees?.map((e) => jsonEncode(e.toMap())).toList());
  }

  @override
  Task copyWith(
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
    return Task(
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
  Displayable toDisplayable({required Color color}) {
    return ViewTask(
        calendarId: this.calendarId,
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
  }
}
