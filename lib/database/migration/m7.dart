import 'package:drift/drift.dart';

import '../app_database.dart';

Future m7(AppDatabase database, Migrator m) async {
  await m.addColumn(database.contactsStorages, database.contactsStorages.ownerMail);
  await m.addColumn(database.contactsStorages, database.contactsStorages.isShared);
  await m.addColumn(database.contactsStorages, database.contactsStorages.accessCode);
}
