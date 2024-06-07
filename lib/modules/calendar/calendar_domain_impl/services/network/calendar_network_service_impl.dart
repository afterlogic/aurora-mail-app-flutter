import 'dart:convert';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/calendar_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/mappers/event_mapper.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service.dart';
import 'package:collection/collection.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class CalendarNetworkServiceImpl implements CalendarNetworkService {
  final WebMailApi calendarModule;

  CalendarNetworkServiceImpl(this.calendarModule);

  @override
  Future<List<Calendar>> getCalendars(int userId) async {
    final body = new WebMailApiBody(
      method: "GetCalendars",
      parameters: null,
    );

    final result = await calendarModule.post(body);
    return (result["Calendars"] as Map)
        .values
        .map((e) => CalendarMapper.fromNetwork(e as Map<String, dynamic>,
            userLocalId: userId))
        .toList();
  }

  @override
  Future<List<EventBase>> getChangesForCalendar(
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

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    return EventMapper.listOfBaseFromNetworkMap(result,
        userLocalId: userLocalId, calendarId: calendarId);
  }

  @override
  Future<List<Event>> updateEvents(List<Event> events) async {
    final parameters = {
      "CalendarId": events.first.calendarId,
      "EventUids": events.map((e) => e.uid).toList()
    };

    final body = new WebMailApiBody(
      method: "GetEventsByUids",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as List;

    return events
        .map(
          (e) => Event.fill(
              e,
              result.firstWhereOrNull((map) => map['uid'] == e.uid)
                  as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<Calendar> createCalendar(
      {required String name,
      String? description,
      required String color,
      required int userLocalId}) async {
    final parameters = {
      "Name": name,
      "Color": color,
      "Description": description ?? ''
    };

    final body = new WebMailApiBody(
      method: "CreateCalendar",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    return CalendarMapper.fromNetwork(result, userLocalId: userLocalId);
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
  Future<void> createEvent(
      {required String subject,
      required String calendarId,
      String? description,
      required DateTime startDate,
      required DateTime endDate,
      }) async {
    // {
    //   "id": null,
    //   "uid": null,
    //   "calendarId": "a2756e51-bf14-4972-b16b-d0df3f3e5b44",
    //   "newCalendarId": "a2756e51-bf14-4972-b16b-d0df3f3e5b44",
    //   "subject": "test creation",
    //   "allDay": 0,
    //   "location": "",
    //   "description": "",
    //   "alarms": "[]",
    //   "attendees": "[]",
    //   "owner": "test@afterlogic.com",
    //   "recurrenceId": null,
    //   "excluded": false,
    //   "allEvents": 2,
    //   "modified": 1,
    //   "start": "2024-05-23T00:00:00+02:00",
    //   "end": "2024-05-24T00:00:00+02:00",
    //   "startTS": 1716415200,
    //   "endTS": 1716501600,
    //   "rrule": null,
    //   "type": "VEVENT",
    //   "status": false,
    //   "withDate": true,
    //   "isPrivate": false,
    //   "selectStart": 1714262400,
    //   "selectEnd": 1717891200
    // };

    final parameters = {
      "id": null,
      "uid": null,
      "calendarId": calendarId,
      "newCalendarId": calendarId,
      "subject": subject,
      "allDay": 0,
      "location": "",
      "description": description ?? '',
      "alarms": "[]",
      "attendees": "[]",
      // "owner": ownerMail,
      "recurrenceId": null,
      "excluded": false,
      "allEvents": 2,
      "modified": 1,
      "start": startDate.toIso8601String(),
      "end": endDate.toIso8601String(),
      "startTS": startDate.toUtc().millisecondsSinceEpoch ~/ 1000,
      "endTS": endDate.toUtc().millisecondsSinceEpoch ~/ 1000,
      "rrule": null,
      "type": "VEVENT",
      "status": false,
      "withDate": true,
      "isPrivate": false,
      // "selectStart": 1714262400,
      // "selectEnd": 1717891200
    };

    final body = new WebMailApiBody(
      method: "CreateEvent",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    print(result);
    // return CalendarMapper.fromNetwork(result, userLocalId: userLocalId);
  }

  @override
  Future<Event> updateEvent(Event event) async{
    final parameters = {
      "id": '${event.uid}-${event.recurrenceId}',
      "uid": event.uid,
      "calendarId": event.calendarId,
      "newCalendarId": event.calendarId,
      "subject": event.subject!,
      "allDay": 0,
      "location": "",
      "description": event.description ?? '',
      "alarms": "[]",
      "attendees": "[]",
      // "owner": ownerMail,
      "recurrenceId": null,
      "excluded": false,
      "allEvents": 2,
      "modified": 1,
      "start": event.startTS!.toIso8601String(),
      "end": event.endTS!.toIso8601String(),
      "startTS": event.startTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
      "endTS": event.endTS!.toUtc().millisecondsSinceEpoch ~/ 1000,
      "rrule": null,
      "type": "VEVENT",
      "status": false,
      "withDate": true,
      "isPrivate": false,
      // "selectStart": 1714262400,
      // "selectEnd": 1717891200
    };

    final body = new WebMailApiBody(
      method: "UpdateEvent",
      parameters: jsonEncode(parameters),
    );

    final result = await calendarModule.post(body) as Map<String, dynamic>;
    return Event.fill(event, (result["Events"] as List).first as Map<String, dynamic>);
  }
}
