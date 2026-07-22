// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_identity_dao.dart';

// ignore_for_file: type=lint
mixin _$AccountIdentityDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountIdentityTableTable get accountIdentityTable =>
      attachedDatabase.accountIdentityTable;
  AccountIdentityDaoManager get managers => AccountIdentityDaoManager(this);
}

class AccountIdentityDaoManager {
  final _$AccountIdentityDaoMixin _db;
  AccountIdentityDaoManager(this._db);
  $$AccountIdentityTableTableTableManager get accountIdentityTable =>
      $$AccountIdentityTableTableTableManager(
          _db.attachedDatabase, _db.accountIdentityTable);
}
