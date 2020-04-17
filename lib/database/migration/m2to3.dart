import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

Future m2to3(AppDatabase database, Migrator m) async {
  await m.issueCustomQuery("ALTER TABLE users DROP COLUMN language");
}
