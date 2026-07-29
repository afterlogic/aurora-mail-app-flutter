// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_infos_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactInfosDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactInfosTable get contactInfos => attachedDatabase.contactInfos;
  ContactInfosDaoManager get managers => ContactInfosDaoManager(this);
}

class ContactInfosDaoManager {
  final _$ContactInfosDaoMixin _db;
  ContactInfosDaoManager(this._db);
  $$ContactInfosTableTableManager get contactInfos =>
      $$ContactInfosTableTableManager(_db.attachedDatabase, _db.contactInfos);
}
