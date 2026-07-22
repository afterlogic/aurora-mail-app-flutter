// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_storages_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactsStoragesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsStoragesTable get contactsStorages =>
      attachedDatabase.contactsStorages;
  ContactsStoragesDaoManager get managers => ContactsStoragesDaoManager(this);
}

class ContactsStoragesDaoManager {
  final _$ContactsStoragesDaoMixin _db;
  ContactsStoragesDaoManager(this._db);
  $$ContactsStoragesTableTableManager get contactsStorages =>
      $$ContactsStoragesTableTableManager(
          _db.attachedDatabase, _db.contactsStorages);
}
