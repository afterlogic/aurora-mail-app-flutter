import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/converters/contacts_info_converter.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

@DataClassName("ContactsStoragesTable")
class ContactsStorages extends Table {
  IntColumn get sqliteId => integer().autoIncrement()();

  IntColumn get userLocalId => integer()();

  IntColumn get idUser => integer()();

  TextColumn get serverId => text()();

  TextColumn get uniqueName => text().customConstraint("UNIQUE")();

  TextColumn get name => text()();

  IntColumn get cTag => integer()();

  BoolColumn get display => boolean()();

  TextColumn get displayName => text().withDefault(Constant(""))();

  TextColumn get contactsInfo =>
      text().map(const ContactsInfoConverter()).nullable()();
}
