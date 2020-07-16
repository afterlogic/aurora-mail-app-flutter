import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

Future m4(AppDatabase database, Migrator m) async {
  await m.addColumn(database.contactsTable, database.contactsTable.autoSign);
  await m.addColumn(database.contactsTable, database.contactsTable.autoEncrypt);
}
