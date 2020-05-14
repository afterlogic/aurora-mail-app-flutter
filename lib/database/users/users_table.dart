import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Users extends Table {
  IntColumn get localId => integer().autoIncrement()();

  IntColumn get serverId => integer()();

  TextColumn get hostname => text()();

  TextColumn get emailFromLogin => text()();

  TextColumn get token => text()();

  IntColumn get syncFreqInSeconds => integer()
      .withDefault(Constant(
          BuildProperty.pushNotification ? SyncFreq.NEVER_IN_SECONDS : 300))
      .nullable()();

  TextColumn get syncPeriod => text().nullable()();
}
