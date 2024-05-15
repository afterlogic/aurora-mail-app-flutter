import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_table.dart';
import 'package:drift/drift.dart';

part 'event_dao.g.dart';

@DriftAccessor(tables: [EventTable])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(AppDatabase db) : super(db);

  Future<List<EventDb>> getAllEventsFromCalendar(
      String calendarUUID, int userLocalId) {
    return (select(eventTable)
          ..where((t) =>
              t.calendarId.equals(calendarUUID) &
              t.userLocalId.equals(userLocalId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startTS),
          ]))
        .get();
  }

  Future<void> deleteAllEventsFromCalendar(
      String calendarUUID, int userLocalId) async {
    await (delete(eventTable)
          ..where((t) =>
              t.calendarId.equals(calendarUUID) &
              t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<void> deleteAllUnusedEvents(
      List<String> calendarUUIDs, List<int> userLocalIds) async {
    await (delete(eventTable)
          ..where((t) =>
              t.calendarId.isNotIn(calendarUUIDs) &
              t.userLocalId.isNotIn(userLocalIds)))
        .go();
  }

  Future<void> createOrUpdateEventList(List<EventDb> events) async {
    for (final event in events) {
      try {
        await into(eventTable).insert(event);
      } catch (e) {
        // If there's a conflict, update the existing record
        await (update(eventTable)..where((tbl) => tbl.id.equals(event.id)))
            .write(event);
      }
    }
  }

  Future<void> deleteEvent({required String uid, required String calendarId, required int userLocalId}) {
    return (delete(eventTable)
      ..where((t) =>
      t.uid.equals(uid) &
      t.calendarId.equals(calendarId) &
      t.userLocalId.equals(userLocalId)))
        .go();
  }
}
