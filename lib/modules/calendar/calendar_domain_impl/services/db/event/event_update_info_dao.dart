import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/event/event_update_info.dart';
import 'package:drift/drift.dart';

part 'event_update_info_dao.g.dart';

@DriftAccessor(tables: [EventUpdateInfoTable])
class EventUpdateInfoDao extends DatabaseAccessor<AppDatabase>
    with _$EventUpdateInfoDaoMixin {
  EventUpdateInfoDao(AppDatabase db) : super(db);

  Future<void> upsert(List<EventUpdateInfoDb> events) async{
    events.forEach((element) async {
      try {
        // Try to insert the calendar
        await into(eventUpdateInfoTable).insert(element);
      } catch (e) {
        // If there's a conflict, update the existing record
        await (update(eventUpdateInfoTable)
          ..where((tbl) => tbl.uid.equals(element.uid)))
            .write(element);
      }
    });
  }
}