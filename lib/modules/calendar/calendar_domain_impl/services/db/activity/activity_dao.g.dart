// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_dao.dart';

// ignore_for_file: type=lint
mixin _$ActivityDaoMixin on DatabaseAccessor<AppDatabase> {
  $ActivityTableTable get activityTable => attachedDatabase.activityTable;
  ActivityDaoManager get managers => ActivityDaoManager(this);
}

class ActivityDaoManager {
  final _$ActivityDaoMixin _db;
  ActivityDaoManager(this._db);
  $$ActivityTableTableTableManager get activityTable =>
      $$ActivityTableTableTableManager(_db.attachedDatabase, _db.activityTable);
}
