// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_groups_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactsGroupsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsGroupsTable get contactsGroups => attachedDatabase.contactsGroups;
  ContactsGroupsDaoManager get managers => ContactsGroupsDaoManager(this);
}

class ContactsGroupsDaoManager {
  final _$ContactsGroupsDaoMixin _db;
  ContactsGroupsDaoManager(this._db);
  $$ContactsGroupsTableTableManager get contactsGroups =>
      $$ContactsGroupsTableTableManager(
          _db.attachedDatabase, _db.contactsGroups);
}
