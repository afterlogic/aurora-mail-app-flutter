// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'white_mail_dao.dart';

// ignore_for_file: type=lint
mixin _$WhiteMailDaoMixin on DatabaseAccessor<AppDatabase> {
  $WhiteMailTableTable get whiteMailTable => attachedDatabase.whiteMailTable;
  WhiteMailDaoManager get managers => WhiteMailDaoManager(this);
}

class WhiteMailDaoManager {
  final _$WhiteMailDaoMixin _db;
  WhiteMailDaoManager(this._db);
  $$WhiteMailTableTableTableManager get whiteMailTable =>
      $$WhiteMailTableTableTableManager(
          _db.attachedDatabase, _db.whiteMailTable);
}
