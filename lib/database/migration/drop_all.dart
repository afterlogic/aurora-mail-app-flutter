import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_database.dart';

Future dropAll(AppDatabase database, Migrator m) async {
  final preference = await SharedPreferences.getInstance();
  await preference.clear();
  final futures = <Future>[];
  for (var value in database.allTables) {
    futures.add(m.deleteTable(value.actualTableName));
  }
  await Future.wait(futures);
  await m.createAll();
}
