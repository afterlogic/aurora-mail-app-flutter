import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
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

  Future<int> deleteAllUnusedEvents(
      List<String> calendarUUIDs, List<int> userLocalIds) async {
    return (delete(eventTable)
          ..where((t) =>
              t.calendarId.isNotIn(calendarUUIDs) &
              t.userLocalId.isNotIn(userLocalIds)))
        .go();
  }

  Future<void> createOrUpdateEventList(List<EventDb> events,
      {bool synced = false}) async {
    for (final event in events) {
      final companion = event.toCompanion(true);
      try {
        await into(eventTable).insert(companion);
      } catch (e) {
        // If there's a conflict, update the existing record
        await (update(eventTable)
              ..where((tbl) =>
                  tbl.uid.equals(event.uid) &
                  tbl.calendarId.equals(event.calendarId) &
                  tbl.userLocalId.equals(event.userLocalId)))
            .write(companion.copyWith(
                synced: Value(synced), onceLoaded: const Value(true)));
      }
    }
  }

  Future<int> deleteMarkedEvents() {
    return (delete(eventTable)
          ..where((t) => t.updateStatus.equals(UpdateStatus.deleted.index)))
        .go();
  }

  Future<List<EventDb>> getEventsWithLimit(
      {required int limit, required int offset}) async {
    return (select(eventTable)..limit(limit, offset: offset)).get();
  }

  Future<void> deleteEvent(
      {required String uid,
      required String calendarId,
      required int userLocalId}) {
    return (delete(eventTable)
          ..where((t) =>
              t.uid.equals(uid) &
              t.calendarId.equals(calendarId) &
              t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<List<EventDb>> getForPeriod(
      {required DateTime start,
      required DateTime end,
      required int userLocalId}) {
    return (select(eventTable)
          ..where((t) =>
              t.userLocalId.equals(userLocalId) &
              t.onceLoaded.equals(true) &
              t.startTS.isBiggerOrEqualValue(start) &
              t.endTS.isSmallerOrEqualValue(end))
          ..orderBy([
            (t) => OrderingTerm(expression: t.startTS),
          ]))
        .get();
  }
}
