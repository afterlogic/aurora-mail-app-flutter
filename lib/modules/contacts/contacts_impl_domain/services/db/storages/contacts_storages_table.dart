import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("ContactsStoragesTable")
class ContactsStorages extends Table {
  IntColumn get sqliteId => integer().autoIncrement()();

  IntColumn get idUser => integer().autoIncrement()();

  TextColumn get serverId => text()();

  TextColumn get name => text()();

  IntColumn get cTag => integer()();
}
