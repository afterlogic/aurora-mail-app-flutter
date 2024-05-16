import 'package:drift/drift.dart';

import '../app_database.dart';

Future m8(AppDatabase database, Migrator m) async {
  await m.createTable(database.calendarTable);
  await m.createTable(database.eventTable);
}
