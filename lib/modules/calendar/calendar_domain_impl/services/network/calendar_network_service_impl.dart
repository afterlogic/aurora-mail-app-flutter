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
}
