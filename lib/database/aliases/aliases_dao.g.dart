// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aliases_dao.dart';

// ignore_for_file: type=lint
mixin _$AliasesDaoMixin on DatabaseAccessor<AppDatabase> {
  $AliasesTableTable get aliasesTable => attachedDatabase.aliasesTable;
  AliasesDaoManager get managers => AliasesDaoManager(this);
}

class AliasesDaoManager {
  final _$AliasesDaoMixin _db;
  AliasesDaoManager(this._db);
  $$AliasesTableTableTableManager get aliasesTable =>
      $$AliasesTableTableTableManager(_db.attachedDatabase, _db.aliasesTable);
}
