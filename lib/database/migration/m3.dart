import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

Future m3(AppDatabase database, Migrator m) async {
  await m.createTable(database.whiteMailTable);
}
