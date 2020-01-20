import 'package:aurora_mail/background/notification_local_storage.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/repository/settings_local_storage.dart';
import 'package:moor_flutter/moor_flutter.dart';

class SettingsMethods {
  final _authLocal = new AuthLocalStorage();
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _notificationStorage = NotificationLocalStorage();
  final _local = SettingsLocalStorage();

  Future<int> get currentUserId {
    return _authLocal.getSelectedUserLocalId();
  }

  Future<User> setFrequency(Freq freq) async {
    final localId = await currentUserId;
    await _usersDao.updateUser(
        localId,
        new UsersCompanion(
          syncFreqInSeconds: Value(SyncFreq.freqToDuration(freq).inSeconds),
        ));

    return _usersDao.getUserByLocalId(localId);
  }

  Future<User> setPeriod(Period period) async {
    final localId = await currentUserId;
    await _usersDao.updateUser(
        localId,
        new UsersCompanion(
          syncPeriod: Value(SyncPeriod.periodToDbString(period)),
        ));

    return _usersDao.getUserByLocalId(localId);
  }

  Future<void> setDarkTheme(bool darkThemeEnabled) {
    return _local.setIsDarkTheme(darkThemeEnabled);
  }

  Future<void> setTimeFormat(bool is24) {
    return _local.setTimeFormat(is24);
  }

  Future<AppSettingsSharedPrefs> getSettingsSharedPrefs() {
    return _local.getSettingsSharedPrefs();
  }

  Future<User> setLanguage(Language language) async {
    final localId = await currentUserId;
    await _usersDao.updateUser(
      localId,
      new UsersCompanion(language: Value(language?.toNullableJson())),
    );

    return _usersDao.getUserByLocalId(localId);
  }

  Future clearNotification() async {
    await _notificationStorage.clear();
  }
}
