//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/models/app_data.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:aurora_mail/modules/settings/models/sync_period.dart';
import 'package:aurora_mail/modules/settings/repository/settings_local_storage.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

class SettingsMethods {
  final AuthLocalStorage _authLocal;

  final UsersDao _usersDao;
  final CryptoStorage cryptoStorage;
  final SettingsLocalStorage _local;

  SettingsMethods(
    this._authLocal,
    this._usersDao,
    this._local,
    this.cryptoStorage,
  );

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

  Future<bool> setAppData(AppData data) {
    return _local.setAppData(data);
  }

  Future<AppData> getAppData() {
    return _local.getAppData();
  }

  Future<void> setTimeFormat(bool is24) {
    return _local.setTimeFormat(is24);
  }

  Future<AppSettingsSharedPrefs> getSettingsSharedPrefs() {
    return _local.getSettingsSharedPrefs();
  }

  Future setLanguage(Language language) async {
    await _local.setLanguage(language?.toNullableJson());
  }

  Future<String> getLanguage() async {
    return _local.getLanguage();
  }

  setUserStorage(User user) {
    cryptoStorage?.setOther(user.emailFromLogin);
  }
}
