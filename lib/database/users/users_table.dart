import 'package:moor_flutter/moor_flutter.dart';

class Users extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get serverId => integer().customConstraint("UNIQUE")();

  TextColumn get hostname => text()();

  // TODO find out
  TextColumn get token => text()();

  IntColumn get syncFreqInSeconds =>
      integer().withDefault(Constant(60)).nullable()();

  TextColumn get syncPeriod => text().nullable()();

  BoolColumn get darkThemeEnabled => boolean().withDefault(Constant(false))();

  TextColumn get language => text().nullable()();
}
