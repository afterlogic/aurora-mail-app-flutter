import 'package:moor_flutter/moor_flutter.dart';

class Users extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get serverId => integer()();

  TextColumn get hostname => text()();

  TextColumn get emailFromLogin => text()();

  TextColumn get token => text()();

  IntColumn get syncFreqInSeconds => integer().withDefault(Constant(60)).nullable()();

  TextColumn get syncPeriod => text().nullable()();

  TextColumn get language => text().nullable()();
}
