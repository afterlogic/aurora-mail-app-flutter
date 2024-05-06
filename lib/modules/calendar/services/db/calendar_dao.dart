import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/services/db/calendar_table.dart';
import 'package:drift/drift.dart';

part 'calendar_dao.g.dart';

@DriftAccessor(tables: [CalendarTable])
class CalendarDao extends DatabaseAccessor<AppDatabase>
    with _$CalendarDaoMixin {
  CalendarDao(AppDatabase db) : super(db);

  Future<List<CalendarDb>> getAllCalendars() {
    return (select(calendarTable)
          ..orderBy([
            (c) => OrderingTerm(expression: c.name),
          ]))
        .get();
  }
}
