import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/rrule.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';


enum ActivityType{
  event,
  task
}

extension ActivityTypeX on ActivityType {
  bool get isEvent => this == ActivityType.event;
  bool get isTask => this == ActivityType.task;
}


abstract class Activity implements ActivityBase{
  bool get onceLoaded;
  ActivityType? get activityType;
  String? get organizer;
  bool? get appointment;
  int? get appointmentAccess;
  String? get subject;
  String? get description;
  String? get location;
  DateTime? get startTS;
  DateTime? get endTS;
  bool? get allDay;
  String? get owner;
  bool? get modified;
  int? get recurrenceId;
  int? get lastModified;
  Rrule? get rrule;
  bool? get status;
  bool? get withDate;
  bool? get isPrivate;
  Set<RemindersOption>? get reminders;
  RecurrenceMode? get recurrenceMode;
  DateTime? get recurrenceUntilDate;
  EveryWeekFrequency? get recurrenceWeeklyFrequency;
  Set<DaysOfWeek>? get recurrenceWeekDays;
  Set<Attendee>? get attendees;

  ActivityBase copyWith({String? organizer,
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
