// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_dao.dart';

// ignore_for_file: type=lint
mixin _$CalendarDaoMixin on DatabaseAccessor<AppDatabase> {
  $CalendarTableTable get calendarTable => attachedDatabase.calendarTable;
  CalendarDaoManager get managers => CalendarDaoManager(this);
}

class CalendarDaoManager {
  final _$CalendarDaoMixin _db;
  CalendarDaoManager(this._db);
  $$CalendarTableTableTableManager get calendarTable =>
      $$CalendarTableTableTableManager(_db.attachedDatabase, _db.calendarTable);
}
