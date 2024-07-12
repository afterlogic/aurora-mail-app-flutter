import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart' show ActivityDb;
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:collection/collection.dart';

extension ActivityMapper on ActivityDb {
  ActivityBase? toActivity() {
    if (!this.onceLoaded) {
      return ActivityBase(
          uid: uid,
          updateStatus: updateStatus,
          userLocalId: userLocalId,
          synced: synced,
          calendarId: calendarId);
    }
    if (this.type?.isTask ?? false) {
      return Task(
          description: description,
          location: location,
          calendarId: calendarId,
          startTS: startTS?.toUtc(),
          endTS: endTS?.toUtc(),
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
          reminders: remindersString != null && remindersString!.isNotEmpty
              ? remindersString!
                  .split(',')
                  .map((e) => RemindersIntMapper.fromInt(int.parse(e)))
                  .whereNotNull()
                  .toSet()
              : {},
          // rrule: null,
          subject: subject,
          updateStatus: updateStatus,
          synced: synced,
          onceLoaded: onceLoaded,
          recurrenceMode: recurrenceMode,
          recurrenceUntilDate: recurrenceUntilDate,
          recurrenceWeeklyFrequency: recurrenceWeeklyFrequency,
          recurrenceWeekDays: recurrenceWeekDaysString != null &&
                  recurrenceWeekDaysString!.isNotEmpty
              ? recurrenceWeekDaysString!
                  .split(',')
                  .map((e) => DaysOfWeekX.fromDaysCode(e))
                  .whereNotNull()
                  .toSet()
              : {},
          attendees: attendees
                  ?.map((e) =>
                      Attendee.fromMap(jsonDecode(e) as Map<String, dynamic>))
                  .toSet() ??
              {});
    }

    if (this.type?.isEvent ?? false) {
      return Event(
          description: description,
          location: location,
          calendarId: calendarId,
          startTS: startTS?.toUtc(),
          endTS: endTS?.toUtc(),
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
          reminders: remindersString != null && remindersString!.isNotEmpty
              ? remindersString!
              .split(',')
              .map((e) => RemindersIntMapper.fromInt(int.parse(e)))
              .whereNotNull()
              .toSet()
              : {},
          // rrule: null,
          subject: subject,
          updateStatus: updateStatus,
          synced: synced,
          onceLoaded: onceLoaded,
          recurrenceMode: recurrenceMode,
          recurrenceUntilDate: recurrenceUntilDate,
          recurrenceWeeklyFrequency: recurrenceWeeklyFrequency,
          recurrenceWeekDays: recurrenceWeekDaysString != null &&
              recurrenceWeekDaysString!.isNotEmpty
              ? recurrenceWeekDaysString!
              .split(',')
              .map((e) => DaysOfWeekX.fromDaysCode(e))
              .whereNotNull()
              .toSet()
              : {},
          attendees: attendees
              ?.map((e) =>
              Attendee.fromMap(jsonDecode(e) as Map<String, dynamic>))
              .toSet() ??
              {});
    }
    return null;
  }
}

class EventMapper {
  static Activity? synchronise(
      {required Map<String, dynamic> newData, required ActivityBase base}) {
    if (base is Task || newData['type'] == ActivityType.task.stringCode) {
      return taskFromJson(newData: newData, base: base);
    }
    if (base is Event || newData['type'] == ActivityType.event.stringCode) {
      return eventFromJson(newData: newData, base: base);
    }
    return null;
  }

  static Task taskFromJson(
      {required Map<String, dynamic> newData, required ActivityBase base}) {
    final rawRrule = newData['rrule'] as Map<String, dynamic>?;

    return Task(

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

  static Event eventFromJson(
      {required Map<String, dynamic> newData, required ActivityBase base}) {
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

  static List<ActivityBase> listOfBaseFromNetworkMap(Map<String, dynamic> map,
      {required int userLocalId, required String calendarId}) {
    final List<ActivityBase> result = [];
    for (final entry in map.entries) {
      final status = UpdateStatusX.fromApiString(entry.key);
      if (status == null) continue;
      result.addAll((entry.value as List).map((e) => ActivityBase(
          uid: e as String,
          synced: false,
          updateStatus: status,
          userLocalId: userLocalId,
          calendarId: calendarId)));
    }
    return result;
  }

  static List<List<ActivityBase>> groupEventsByCalendarId(
      List<ActivityBase> models) {
    Map<String, List<ActivityBase>> groupedMap = {};

    for (final ActivityBase model in models) {
      if (!groupedMap.containsKey(model.calendarId)) {
        groupedMap[model.calendarId] = [];
      }
      groupedMap[model.calendarId]!.add(model);
    }

    return groupedMap.values.toList();
  }
}
