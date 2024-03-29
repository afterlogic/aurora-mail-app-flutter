import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

@DataClassName("ContactsGroupsTable")
class ContactsGroups extends Table {
  TextColumn get uuid => text().customConstraint("UNIQUE")();

  IntColumn get userLocalId => integer()();

  IntColumn get idUser => integer()();

  TextColumn get city => text()();

  TextColumn get company => text()();

  TextColumn get country => text()();

  TextColumn get email => text()();

  TextColumn get fax => text()();

  BoolColumn get isOrganization => boolean()();

  TextColumn get name => text()();

  TextColumn get parentUUID => text()();

  TextColumn get phone => text()();

  TextColumn get state => text()();

  TextColumn get street => text()();

  TextColumn get web => text()();

  TextColumn get zip => text()();
}
