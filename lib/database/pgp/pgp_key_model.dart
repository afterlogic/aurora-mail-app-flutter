import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("LocalPgpKey")
class PgpKeyModel extends Table {
  @override
  Set<Column> get primaryKey => {other, id};

  TextColumn get id => text()();

  TextColumn get name => text().nullable()();

  TextColumn get mail => text()();

  BoolColumn get isPrivate => boolean()();

  IntColumn get length => integer().nullable()();

  TextColumn get other => text()();
}
