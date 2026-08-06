import 'package:drift/drift.dart';

import '../app_database.dart';

Future m5(AppDatabase database, Migrator m) async {
  await database.customStatement('DELETE FROM ${database.folders.actualTableName};');
}
