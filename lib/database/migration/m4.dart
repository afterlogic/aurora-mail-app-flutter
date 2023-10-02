import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';

Future m4(AppDatabase database, Migrator m) async {
  await m.addColumn(database.contactsTable, database.contactsTable.autoSign);
  await m.addColumn(database.contactsTable, database.contactsTable.autoEncrypt);
}
