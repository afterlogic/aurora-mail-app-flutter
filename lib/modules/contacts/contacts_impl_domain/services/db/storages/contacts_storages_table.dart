import 'package:drift/drift.dart';

@DataClassName("ContactsStoragesTable")
class ContactsStorages extends Table {
  IntColumn get sqliteId => integer().autoIncrement().nullable()();

  IntColumn get userLocalId => integer()();

  IntColumn get idUser => integer()();

  TextColumn get serverId => text()();

  TextColumn get uniqueName => text().customConstraint("UNIQUE")();

  TextColumn get name => text()();

  IntColumn get cTag => integer()();

  BoolColumn get display => boolean()();

  TextColumn get displayName => text().withDefault(Constant(""))();

  TextColumn get ownerMail => text().nullable()();

  BoolColumn get isShared => boolean().nullable()();

  IntColumn get accessCode => integer().nullable()();
}
