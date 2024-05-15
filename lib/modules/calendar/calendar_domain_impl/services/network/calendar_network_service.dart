import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service_impl.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

abstract class CalendarNetworkService {
  factory CalendarNetworkService(WebMailApi calendarModule, int userId) {
    return CalendarNetworkServiceImpl(calendarModule);
  }
  Future<List<Calendar>> getCalendars(int userId);

  Future<List<EventUpdateInfo>> getChangesForCalendar(
      {required String calendarId,
      required int userLocalId,
      required int syncTokenFrom,
      int? limit});

  Future<List<Event>> getEvents(
      {required List<String> uuids, required String calendarId, required int userId});
}
