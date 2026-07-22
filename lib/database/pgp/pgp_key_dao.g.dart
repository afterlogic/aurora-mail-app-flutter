// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgp_key_dao.dart';

// ignore_for_file: type=lint
mixin _$PgpKeyDaoMixin on DatabaseAccessor<AppDatabase> {
  $PgpKeyModelTable get pgpKeyModel => attachedDatabase.pgpKeyModel;
  PgpKeyDaoManager get managers => PgpKeyDaoManager(this);
}

class PgpKeyDaoManager {
  final _$PgpKeyDaoMixin _db;
  PgpKeyDaoManager(this._db);
  $$PgpKeyModelTableTableManager get pgpKeyModel =>
      $$PgpKeyModelTableTableManager(_db.attachedDatabase, _db.pgpKeyModel);
}
