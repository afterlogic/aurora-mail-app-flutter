import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

@DataClassName("WhiteMail")
class WhiteMailTable extends Table {
  Set<Column> get primaryKey => {mail};

  TextColumn get mail => text()();
}
