import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:moor_flutter/moor_flutter.dart';

class SettingsMethods {
  final _usersDao = new UsersDao(DBInstances.appDB);

  Future<User> setFrequency(Freq freq) async {
    final localId = AuthBloc.currentUser.localId;
    await _usersDao.updateUser(
        localId,
        new UsersCompanion(
          syncFreqInSeconds: Value(SyncFreq.freqToDuration(freq).inSeconds),
        ));

    return _usersDao.getUserByLocalId(localId);
  }

  Future<User> setPeriod(Period period) async {
    final localId = AuthBloc.currentUser.localId;
    await _usersDao.updateUser(
        localId,
        new UsersCompanion(
          syncPeriod: Value(SyncPeriod.periodToDbString(period)),
        ));

    return _usersDao.getUserByLocalId(localId);
  }

  Future<User> setDarkTheme(bool darkThemeEnabled) async {
    final localId = AuthBloc.currentUser.localId;
    await _usersDao.updateUser(
      localId,
      new UsersCompanion(darkThemeEnabled: Value(darkThemeEnabled)),
    );

    return _usersDao.getUserByLocalId(localId);
  }

  Future<User> setLanguage(Language language) async {
    final localId = AuthBloc.currentUser.localId;
    await _usersDao.updateUser(
      localId,
      new UsersCompanion(language: Value(language?.toNullableJson())),
    );

    return _usersDao.getUserByLocalId(localId);
  }
}
