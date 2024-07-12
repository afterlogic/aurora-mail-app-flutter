import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/rrule.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:flutter/material.dart';

abstract class Displayable extends Activity{
  Color get color;
  Displayable copyWith({ Color? color, String? organizer,
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
    Set<RemindersOption>? reminders});
}
