import 'package:drift/drift.dart';

import '../app_database.dart';

Future m6(AppDatabase database, Migrator m) async {
  await m.addColumn(database.contactsStorages, database.contactsStorages.displayName);
}
