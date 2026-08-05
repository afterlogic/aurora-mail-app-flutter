import 'package:drift/drift.dart';

@DataClassName("ContactInfoRow")
class ContactInfos extends Table {
  IntColumn get sqliteId => integer().autoIncrement()();

  IntColumn get userLocalId => integer()();

  TextColumn get storage => text()();

  TextColumn get uuid => text()();

  TextColumn get eTag => text().nullable()();

  BoolColumn get hasBody => boolean().withDefault(Constant(false))();

  BoolColumn get needsUpdate => boolean().withDefault(Constant(false))();
}
