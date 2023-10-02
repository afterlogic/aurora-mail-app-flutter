import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import '../app_database.dart';

Future m2(AppDatabase database, Migrator m) async {
  await m.issueCustomQuery("ALTER TABLE users DROP COLUMN language");
}
