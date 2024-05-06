import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/services/db/event_table.dart';
import 'package:drift/drift.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [EventTable])
class EventDao extends DatabaseAccessor<AppDatabase>
    with _$EventDaoMixin {
  EventDao(AppDatabase db) : super(db);

  Future<List<EventDb>> getAllEventsFromCalendar(String calendarUUID) {
    return (select(eventTable)
      ..where((c) => c.calendarId.equals(calendarUUID))
      ..orderBy([
            (c) => OrderingTerm(expression: c.startTS),
      ]))
        .get();
  }
}
