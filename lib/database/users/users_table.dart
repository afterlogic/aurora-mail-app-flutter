import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get localId => integer().autoIncrement().nullable()();

  IntColumn get serverId => integer()();

  TextColumn get hostname => text()();

  TextColumn get emailFromLogin => text()();

  TextColumn get token => text()();

  IntColumn get syncFreqInSeconds => integer()
      .withDefault(Constant(SyncFreq.defaultFreqInSeconds))
      .nullable()();

  TextColumn get syncPeriod => text().nullable()();
}
