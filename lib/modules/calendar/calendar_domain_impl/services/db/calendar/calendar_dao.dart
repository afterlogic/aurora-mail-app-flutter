import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_table.dart';
import 'package:drift/drift.dart';

part 'calendar_dao.g.dart';

@DriftAccessor(tables: [CalendarTable])
class CalendarDao extends DatabaseAccessor<AppDatabase>
    with _$CalendarDaoMixin {
  CalendarDao(AppDatabase db) : super(db);

  Future<List<CalendarDb>> getAllCalendars(int userLocalId) {
    return (select(calendarTable)
          ..where((t) => t.userLocalId.equals(userLocalId))
          ..orderBy([
            (c) => OrderingTerm(expression: c.name),
          ]))
        .get();
  }

  Future<void> deleteAllCalendars([int? userLocalId]) async {
    if (userLocalId != null) {
      await (delete(calendarTable)
            ..where((t) => t.userLocalId.equals(userLocalId)))
          .go();
    }else{
      await delete(calendarTable).go();
    }
  }

  Future<void> deleteCalendars(List<String> ids) async {
    await (delete(calendarTable)..where((t) => t.id.isIn(ids))).go();
  }

  Future<void> createOrUpdateCalendar(CalendarDb calendar) async {
    try {
      await into(calendarTable).insert(calendar);
    } catch (e) {
      // If there's a conflict, update the existing record
      await (update(calendarTable)
            ..where((tbl) =>
                tbl.id.equals(calendar.id) &
                tbl.userLocalId.equals(calendar.userLocalId)))
          .write(calendar);
    }
  }
}
