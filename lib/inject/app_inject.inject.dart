import 'dart:async' as _i13;

import 'package:crypto_storage/src/pgp_storage.dart' as _i7;
import 'package:crypto_worker/src/pgp/pgp_worker.dart' as _i8;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;

import '../database/pgp/pgp_key_dao.dart' as _i6;
import '../database/users/users_dao.dart' as _i11;
import '../modules/auth/repository/auth_local_storage.dart' as _i10;
import '../modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart' as _i14;
import '../modules/settings/blocs/settings_bloc/settings_methods.dart' as _i15;
import '../modules/settings/repository/settings_local_storage.dart' as _i12;
import 'app_inject.dart' as _i1;
import 'modules/crypto_module.dart' as _i2;
import 'modules/dao_module.dart' as _i5;
import 'modules/logic_module.dart' as _i9;
import 'modules/storage_module.dart' as _i3;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._cryptoModule, this._storageModule,
      this._daoModule, this._logicModule);

  final _i2.CryptoModule _cryptoModule;

  final _i3.StorageModule _storageModule;

  _i4.FlutterSecureStorage _singletonFlutterSecureStorage;

  final _i5.DaoModule _daoModule;

  _i6.PgpKeyDao _singletonPgpKeyDao;

  _i7.CryptoStorage _singletonCryptoStorage;

  _i8.PgpWorker _singletonPgpWorker;

  final _i9.LogicModule _logicModule;

  _i10.AuthLocalStorage _singletonAuthLocalStorage;

  _i11.UsersDao _singletonUsersDao;

  _i12.SettingsLocalStorage _singletonSettingsLocalStorage;

  static _i13.Future<_i1.AppInjector> create(
      _i2.CryptoModule cryptoModule,
      _i5.DaoModule daoModule,
      _i3.StorageModule storageModule,
      _i9.LogicModule logicModule) async {
    final injector = AppInjector$Injector._(
        cryptoModule, storageModule, daoModule, logicModule);

    return injector;
  }

  _i8.PgpWorker _createPgpWorker() =>
      _singletonPgpWorker ??= _cryptoModule.pgpWorker(_createCryptoStorage());

  _i7.CryptoStorage _createCryptoStorage() =>
      _singletonCryptoStorage ??= _cryptoModule.cryptoStorage(
          _createFlutterSecureStorage(), _createPgpKeyDao());

  _i4.FlutterSecureStorage _createFlutterSecureStorage() =>
      _singletonFlutterSecureStorage ??= _storageModule.flutterSecureStorage();

  _i6.PgpKeyDao _createPgpKeyDao() =>
      _singletonPgpKeyDao ??= _daoModule.pgpKeyDao();

  _i14.PgpSettingsBloc _createPgpSettingsBloc() =>
      _logicModule.pgpSettingsBloc(_createCryptoStorage(), _createPgpWorker());

  _i15.SettingsMethods _createSettingsMethods() => _logicModule.settingsMethods(
      _createAuthLocalStorage(),
      _createUsersDao(),
      _createSettingsLocalStorage(),
      _createCryptoStorage());

  _i10.AuthLocalStorage _createAuthLocalStorage() =>
      _singletonAuthLocalStorage ??= _storageModule.authLocalStorage();

  _i11.UsersDao _createUsersDao() =>
      _singletonUsersDao ??= _daoModule.userDao();

  _i12.SettingsLocalStorage _createSettingsLocalStorage() =>
      _singletonSettingsLocalStorage ??= _storageModule.settingsLocalStorage();

  @override
  _i8.PgpWorker pgpWorker() => _createPgpWorker();

  @override
  _i14.PgpSettingsBloc pgpSettingsBloc() => _createPgpSettingsBloc();

  @override
  _i15.SettingsMethods settingsMethods() => _createSettingsMethods();
}
