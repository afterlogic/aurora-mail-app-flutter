import 'dart:convert';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/reminders_option.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service.dart';
import 'package:collection/collection.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class CalendarNetworkServiceImpl implements CalendarNetworkService {
  final WebMailApi calendarModule;

  const CalendarNetworkServiceImpl(this.calendarModule);

  @override
  Future<List<Calendar>> getCalendars(int userId) async {
    final body = new WebMailApiBody(
      method: "GetCalendars",
      parameters: null,
    );

    final result = await calendarModule.post(body);
    return CalendarMapper.listFromNetwork(
        (result["Calendars"] as Map).values.toList(),
        serverUrl: (result["ServerUrl"] as String?)!,
        userLocalId: userId);
  }

  @override
  Future<List<ActivityBase>> getChangesForCalendar(
      {required String calendarId,
      required int userLocalId,
      required int syncTokenFrom,
      int? limit}) async {
    final parameters = {
      "CalendarId": calendarId,
      "SyncToken": syncTokenFrom,
    };

    if (limit != null) {
      parameters.addAll({"limit": limit});
    }

    final body = new WebMailApiBody(
      method: "GetChangesForCalendar",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body);
    return EventMapper.listOfBaseFromNetworkMap(result as Map<String, dynamic>,
        userLocalId: userLocalId, calendarId: calendarId);
  }

  @override
  Future<List<Activity>> updateActivities(List<ActivityBase> activities) async {
    final parameters = {
      "CalendarId": activities.first.calendarId,
      "EventUids": activities.map((e) => e.uid).toList()
    };

    final body = new WebMailApiBody(
      method: "GetEventsByUids",
      parameters: jsonEncode(parameters),
    );

    final queryResult = await calendarModule.post(body) as List;

    final result = <Activity>[];
    for (final rawEvent in queryResult) {
      try {
        final baseEvent =
            activities.firstWhereOrNull((e) => rawEvent['uid'] == e.uid);
        if (baseEvent == null)
          throw Exception('event info not found from Event from server');
        final synchronisedActivity = EventMapper.synchronise(
            newData: rawEvent as Map<String, dynamic>, base: baseEvent);
        if (synchronisedActivity == null) {
          throw Exception('Unknown activity type');
        }
        result.add(synchronisedActivity);
      } catch (e, st) {
        print(e);
        print(st);
      } finally {
        continue;
      }
    }
    return result;
  }

  @override
  Future<Calendar> createCalendar(
      {required String name,
      String? description,
      required String color,
      required int userLocalId}) async {
    final createCalendarParameters = {
      "Name": name,
      "Color": color,
      "Description": description ?? ''
    };

    final createCalendarBody = new WebMailApiBody(
      method: "CreateCalendar",
      parameters: jsonEncode(createCalendarParameters),
    );

    final createCalendarResult =
        await calendarModule.post(createCalendarBody) as Map<String, dynamic>;

    // another query to get server url
    final getCalendarsBody = new WebMailApiBody(
      method: "GetCalendars",
      parameters: null,
    );

    final getCalendarsResult = await calendarModule.post(getCalendarsBody);

    return CalendarMapper.fromNetwork(createCalendarResult,
        userLocalId: userLocalId,
        serverUrl: (getCalendarsResult["ServerUrl"] as String?)!);
  }

  @override
  Future<void> deleteCalendar({required String id}) async {
    final parameters = {"Id": id};

    final body = new WebMailApiBody(
      method: "DeleteCalendar",
      parameters: jsonEncode(parameters),
    );

    await calendarModule.post(body);
  }

  @override
  Future<bool> updateCalendar(
      {required String id,
      required String name,
      required String description,
      required String color}) async {
    final parameters = {
      "Id": id,
      "Name": name,
      "Color": color,
      "Description": description
    };

    final body = new WebMailApiBody(
      method: "UpdateCalendar",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as bool;
    return result;
  }

  @override
  Future<void> createActivity({
    required ActivityCreationData creationData,
  }) async {
    // location: data.location ?? '',
    // subject: data.subject,
    // calendarId: data.calendarId,
    // startDate: data.startDate,
    // endDate: data.endDate,
    // allDay: data.allDay,
    // description: data.description ?? '',
    // reminders: data.reminders.map((e) => e.toInt).toList(),
    // recurrenceMode: data.recurrenceMode,
    // recurrenceUntilDate: data.recurrenceUntilDate,
    // recurrenceWeeklyFrequency: data.recurrenceWeeklyFrequency,
    // recurrenceWeekDays: data.recurrenceWeekDays,
    // attendees: data.attendees
    late final ActivityType type;
    if (creationData is EventCreationData) {
      type = ActivityType.event;
    } else if (creationData is TaskCreationData) {
      type = ActivityType.task;
    } else {
      throw Exception('unknown ActivityCreationData subtype');
    }

    final rruleParameters = creationData.recurrenceMode == RecurrenceMode.never
        ? null
        : {
            "startBase": creationData.startDate == null
                ? null
                : creationData.startDate!.toUtc().millisecondsSinceEpoch ~/
                    1000,
            "endBase": creationData.endDate == null
                ? null
                : creationData.endDate!.toUtc().millisecondsSinceEpoch ~/ 1000,
            "period": creationData.recurrenceMode.periodCode,
            "until": creationData.recurrenceUntilDate == null
                ? 0
                : creationData.recurrenceUntilDate!
                        .toUtc()
                        .millisecondsSinceEpoch ~/
                    1000,
            "interval": creationData.recurrenceWeeklyFrequency == null
                ? 1
                : creationData.recurrenceWeeklyFrequency!.intervalCode,
            "end": creationData.recurrenceUntilDate == null ? 3 : 2,
            "byDays": creationData.recurrenceWeekDays == null
                ? []
                : creationData.recurrenceWeekDays!
                    .map((e) => e.byDaysCode)
                    .toList(),
            "weekNum": null,
            "count": null
          };

    final parameters = {
      "id": null,
      "uid": null,
      "calendarId": creationData.calendarId,
      "newCalendarId": creationData.calendarId,
      "subject": creationData.subject,
      "allDay": creationData.allDay == true ? 1 : 0,
      "location": creationData.location ?? '',
      "description": creationData.description ?? '',
      "alarms":
          "[${creationData.reminders.map((e) => e.toInt).toList().join(',')}]",
      "recurrenceId": null,
      "excluded": false,
      "allEvents": 2,
      "modified": 1,
      "start": creationData.startDate == null
          ? null
          : creationData.startDate!.toIso8601String(),
      "end": creationData.endDate == null
          ? null
          : creationData.endDate!.toIso8601String(),
      "startTS": creationData.startDate == null
          ? null
          : creationData.startDate!.toUtc().millisecondsSinceEpoch ~/ 1000,
      "endTS": creationData.endDate == null
          ? null
          : creationData.endDate!.toUtc().millisecondsSinceEpoch ~/ 1000,
      "rrule": null,
      "type": type.stringCode,
      "status": false,
      "withDate": true,
      "isPrivate": false,
    };

    if (creationData is EventCreationData &&
        creationData.attendees.isNotEmpty) {
      parameters.addAll({
        "attendees":
            jsonEncode(creationData.attendees.map((e) => e.toMap()).toList())
      });
    }

    if (rruleParameters != null) {
      parameters.addAll({"rrule": jsonEncode(rruleParameters)});
    }

    final body = new WebMailApiBody(
      method: "CreateEvent",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    print(result);
  }

  @override
  Future<Activity> updateActivity(Activity activity) async {
    final type = _getActivityType(activity);
    final dateInfo = _getDateInfo(activity);
    final rruleParameters = activity.recurrenceMode == RecurrenceMode.never
        ? null
        : {
            "startBase": activity.startTS == null
                ? null
                : activity.startTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
            "endBase": activity.endTS == null
                ? null
                : activity.endTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
            "period": activity.recurrenceMode!.periodCode,
            "until": activity.recurrenceUntilDate == null
                ? 0
                : activity.recurrenceUntilDate!
                        .toUtc()
                        .millisecondsSinceEpoch ~/
                    1000,
            "interval": activity.recurrenceWeeklyFrequency == null
                ? 1
                : activity.recurrenceWeeklyFrequency!.intervalCode,
            "end": activity.recurrenceUntilDate == null ? 3 : 2,
            "byDays": activity.recurrenceWeekDays == null
                ? []
                : activity.recurrenceWeekDays!
                    .map((e) => e.byDaysCode)
                    .toList(),
            "weekNum": null,
            "count": null
          };
    final parameters = {
      "id": '${activity.uid}-${activity.recurrenceId}',
      "uid": activity.uid,
      "calendarId": activity.calendarId,
      "newCalendarId": activity.calendarId,
      "subject": activity.subject!,
      "allDay": activity.allDay == true ? 1 : 0,
      "location": activity.location ?? '',
      "description": activity.description ?? '',
      "alarms": activity.reminders == null
          ? "[]"
          : "[${activity.reminders!.map((e) => e.toInt).join(',')}]",
      "recurrenceId": null,
      "excluded": false,
      "allEvents": 2,
      "modified": 1,
      "type": type.stringCode,
      "status": activity.status ?? false,
      "withDate": true,
      "isPrivate": false,
    };

    parameters.addAll(dateInfo);

    if (activity is Event) {
      parameters.addAll({
        "attendees":
            jsonEncode(activity.attendees.map((e) => e.toMap()).toList())
      });
    }

    if (rruleParameters != null) {
      parameters.addAll({"rrule": jsonEncode(rruleParameters)});
    }

    final body = new WebMailApiBody(
      method: "UpdateEvent",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    final syncResult = EventMapper.synchronise(
        newData: (result["Events"] as List).first as Map<String, dynamic>,
        base: activity);
    if (syncResult == null)
      throw Exception('synchronise error while updating activity');

    return syncResult;
  }

  @override
  Future<void> deleteActivity(Activity activity) async {
    final type = _getActivityType(activity);
    final dateInfo = _getDateInfo(activity);

    final parameters = {
      "id": '${activity.uid}-${activity.recurrenceId}',
      "uid": activity.uid,
      "calendarId": activity.calendarId,
      "newCalendarId": activity.calendarId,
      "subject": activity.subject!,
      "allDay": activity.allDay == true ? 1 : 0,
      "location": activity.location ?? '',
      "description": activity.description ?? '',
      "alarms": "[]",
      "attendees": "[]",
      "recurrenceId": null,
      "excluded": false,
      "allEvents": 2,
      "modified": 1,
      "rrule": null,
      "type": type.stringCode,
      "status": activity.status ?? false,
      "withDate": true,
      "isPrivate": false,
    };

    parameters.addAll(dateInfo);

    final body = new WebMailApiBody(
      method: "DeleteEvent",
      parameters: jsonEncode(parameters),
    );

    await calendarModule.post(body);
  }

  @override
  Future<bool> updateSharing(
      {required List<Participant> participants,
      required String calendarId}) async {
    final sharedToAll = participants.whereType<ParticipantAll>().firstOrNull;
    final parameters = {
      "Id": calendarId,
      "IsPublic": 0,
      "Shares": jsonEncode(participants.map((e) => e.toMap()).toList()),
      "ShareToAll": sharedToAll == null ? 0 : 1,
      "ShareToAllAccess": sharedToAll?.permissions.code ?? 2
    };

    final body = new WebMailApiBody(
      method: "UpdateCalendarShare",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as bool;
    return result;
  }

  @override
  Future<bool> updateCalendarPublic(
      {required String calendarId, required bool isPublic}) async {
    final parameters = {"Id": calendarId, "IsPublic": isPublic};

    final body = new WebMailApiBody(
      method: "UpdateCalendarPublic",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as bool;
    return result;
  }

  ActivityType _getActivityType(Activity activity) {
    if (activity is Event) {
      return ActivityType.event;
    } else if (activity is Task) {
      return ActivityType.task;
    } else {
      throw Exception('unknown Activity subtype');
    }
  }

  Map<String, dynamic> _getDateInfo(Activity activity) {
    return {
      "start":
          activity.startTS == null ? null : activity.startTS!.toIso8601String(),
      "end": activity.endTS == null ? null : activity.endTS!.toIso8601String(),
      "startTS": activity.startTS == null
          ? null
          : activity.startTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
      "endTS": activity.endTS == null
          ? null
          : activity.endTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
    };
  }
}
