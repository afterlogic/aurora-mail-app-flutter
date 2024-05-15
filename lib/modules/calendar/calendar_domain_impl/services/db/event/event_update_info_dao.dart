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
        await into(eventUpdateInfoTable).insert(element);
      } catch (e) {
        // If there's a conflict, update the existing record
        await (update(eventUpdateInfoTable)
          ..where((tbl) => tbl.uid.equals(element.uid)))
            .write(element);
      }
    });
  }

  Future<void> deleteInfoFromCalendar(
      {required String uid, required String calendarUUID,required int userLocalId}) async {
    await (delete(eventUpdateInfoTable)
      ..where((t) =>
      t.uid.equals(uid) &
      t.calendarId.equals(calendarUUID) &
      t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<void> deleteAllInfoFromCalendar(
      String calendarUUID, int userLocalId) async {
    await (delete(eventUpdateInfoTable)
      ..where((t) =>
      t.calendarId.equals(calendarUUID) &
      t.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<void> deleteAllUnusedInfo(
      List<String> calendarUUIDs, List<int> userLocalIds) async {
    await (delete(eventUpdateInfoTable)
      ..where((t) =>
      t.calendarId.isNotIn(calendarUUIDs) &
      t.userLocalId.isNotIn(userLocalIds)))
        .go();
  }

  Future<List<EventUpdateInfoDb>> getList(int limit) async {
    return (select(eventUpdateInfoTable)..limit(limit)).get();
  }
}