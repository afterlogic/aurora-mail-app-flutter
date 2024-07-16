import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/attendee.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/network/calendar_network_service_impl.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

abstract class CalendarNetworkService {
  factory CalendarNetworkService(WebMailApi calendarModule, int userId) {
    return CalendarNetworkServiceImpl(calendarModule);
  }
  Future<List<Calendar>> getCalendars(int userId);

  Future<List<ActivityBase>> getChangesForCalendar(
      {required String calendarId,
      required int userLocalId,
      required int syncTokenFrom,
      int? limit});

  Future<List<Activity>> updateActivities(List<ActivityBase> activities);

  Future<void> createActivity({
    required ActivityCreationData creationData,
});

  Future<Activity> updateActivity(Activity activity);

  Future<void> deleteEvent(Event event);

  Future<bool> updateSharing({required List<Participant> participants, required String calendarId});

  Future<void> deleteCalendar(
      {required String id});

  Future<bool> updateCalendar(
      {required String id, required String name, required String description, required String color, });

  Future<Calendar> createCalendar(
      {required String name, String? description, required String color, required int userLocalId});

  Future<bool> updateCalendarPublic({required String calendarId, required bool isPublic});
}
