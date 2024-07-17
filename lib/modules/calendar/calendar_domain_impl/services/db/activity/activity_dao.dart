import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/activity/activity_table.dart';
import 'package:drift/drift.dart';

part 'activity_dao.g.dart';

@DriftAccessor(tables: [ActivityTable])
class ActivityDao extends DatabaseAccessor<AppDatabase>
    with _$ActivityDaoMixin {
  ActivityDao(AppDatabase db) : super(db);

  Future<List<ActivityDb>> getAllEventsFromCalendar(
      String calendarUUID, int userLocalId) {
    return (select(activityTable)
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
    await (delete(activityTable)
          ..where((t) =>
              t.calendarId.equals(calendarUUID) &
              t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<int> deleteAllUnusedEvents(
      List<String> calendarUUIDs, List<int> userLocalIds) async {
    return (delete(activityTable)
          ..where((t) =>
              t.calendarId.isNotIn(calendarUUIDs) &
              t.userLocalId.isNotIn(userLocalIds)))
        .go();
  }

  Future<void> syncEventList(List<ActivityDb> events,
      {bool synced = false}) async {
    for (final event in events) {
      final companion = event.toCompanion(true);
      try {
        await into(activityTable).insert(companion);
      } catch (e) {
        // If there's a conflict, update the existing record

        await (update(activityTable)
              ..where((tbl) =>
                  tbl.uid.equals(event.uid) &
                  tbl.calendarId.equals(event.calendarId) &
                  tbl.userLocalId.equals(event.userLocalId)))
            .write(companion.copyWith(
          synced: Value(synced),
        ));
      } finally {
        if (event.updateStatus.isDeleted) {
          await (deleteEvent(
              uid: event.uid,
              calendarId: event.calendarId,
              userLocalId: event.userLocalId));
        }
      }
    }
  }

  Future<int> deleteMarkedEvents() {
    return (delete(activityTable)
          ..where((t) => t.updateStatus.equals(UpdateStatus.deleted.index)))
        .go();
  }

  Future<List<ActivityDb>> getEventsWithLimit(
      {required int? limit, required int? offset}) async {
    if (limit == null || offset == null) return select(activityTable).get();
    return (select(activityTable)..limit(limit, offset: offset)).get();
  }

  Future<void> deleteEvent(
      {required String uid,
      required String calendarId,
      required int userLocalId}) {
    return (delete(activityTable)
          ..where((t) =>
              t.uid.equals(uid) &
              t.calendarId.equals(calendarId) &
              t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<List<ActivityDb>> getForPeriod(
      {required DateTime start,
      required DateTime end,
      ActivityType? type,
      required List<String> calendarIds,
      required int userLocalId}) {
    final activitySelect = select(activityTable);
    if (type != null) {
      activitySelect.where((t) => t.type.equals(type.index));
    }
    activitySelect.where((t) =>
        t.userLocalId.equals(userLocalId) &
        t.calendarId.isIn(calendarIds) &
        t.onceLoaded.equals(true) &
        t.startTS.isBiggerOrEqualValue(start) &
        t.endTS.isSmallerThanValue(end));
    activitySelect.orderBy([
      (t) => OrderingTerm(expression: t.startTS),
    ]);
    return activitySelect.get();
  }

  Future<List<ActivityDb>> getAll(
      {ActivityType? type,
      required List<String>? calendarIds,
      required ActivityFilter filter,
      required int userLocalId}) {
    final activitySelect = select(activityTable);
    if (type != null) {
      activitySelect.where((t) => t.type.equals(type.index));
    }
    if (calendarIds != null) {
      activitySelect.where((t) => t.calendarId.isIn(calendarIds));
    }
    switch (filter.date) {
      case ActivityDateFilter.hasDate:
        activitySelect
            .where((t) => t.startTS.isNotNull() & t.endTS.isNotNull());
        break;
      case ActivityDateFilter.withoutDate:
        activitySelect.where((t) => t.startTS.isNull() & t.endTS.isNull());
        break;
      case ActivityDateFilter.all:
        break;
    }
    switch (filter.status) {
      case ActivityStatusFilter.completedOnly:
        activitySelect.where((t) => t.status.equals(true));
        break;
      case ActivityStatusFilter.all:
        break;
    }
    activitySelect.where(
        (t) => t.userLocalId.equals(userLocalId) & t.onceLoaded.equals(true));
    activitySelect.orderBy([
      (t) => OrderingTerm(expression: t.startTS),
    ]);
    return activitySelect.get();
  }

  Future<void> deleteAllEvents([int? userLocalId]) async {
    if (userLocalId != null) {
      await (delete(activityTable)
            ..where((t) => t.userLocalId.equals(userLocalId)))
          .go();
    } else {
      await delete(activityTable).go();
    }
  }
}
