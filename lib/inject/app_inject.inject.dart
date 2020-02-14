import 'app_inject.dart' as _i1;
import 'modules/logic_module.dart' as _i2;
import 'modules/crypto_module.dart' as _i3;
import 'modules/storage_module.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'modules/dao_module.dart' as _i6;
import '../database/pgp/pgp_key_dao.dart' as _i7;
import 'package:crypto_storage/src/pgp_storage.dart' as _i8;
import 'package:crypto_plugin/algorithm/pgp.dart' as _i9;
import 'package:crypto_worker/src/pgp/pgp_worker.dart' as _i10;
import '../modules/auth/repository/auth_local_storage.dart' as _i11;
import '../database/users/users_dao.dart' as _i12;
import '../modules/settings/repository/settings_local_storage.dart' as _i13;
import 'dart:async' as _i14;
import '../modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart' as _i15;
import '../modules/settings/blocs/settings_bloc/settings_methods.dart' as _i16;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._logicModule, this._cryptoModule,
      this._storageModule, this._daoModule);

  final _i2.LogicModule _logicModule;

  final _i3.CryptoModule _cryptoModule;

  final _i4.StorageModule _storageModule;

  _i5.FlutterSecureStorage _singletonFlutterSecureStorage;

  final _i6.DaoModule _daoModule;

  _i7.PgpKeyDao _singletonPgpKeyDao;

  _i8.CryptoStorage _singletonCryptoStorage;

  _i9.Pgp _singletonPgp;

  _i10.PgpWorker _singletonPgpWorker;

  _i11.AuthLocalStorage _singletonAuthLocalStorage;

  _i12.UsersDao _singletonUsersDao;

  _i13.SettingsLocalStorage _singletonSettingsLocalStorage;

  static _i14.Future<_i1.AppInjector> create(
      _i3.CryptoModule cryptoModule,
      _i6.DaoModule daoModule,
      _i4.StorageModule storageModule,
      _i2.LogicModule logicModule) async {
    final injector = AppInjector$Injector._(
        logicModule, cryptoModule, storageModule, daoModule);

    return injector;
  }

  _i15.PgpSettingsBloc _createPgpSettingsBloc() =>
      _logicModule.pgpSettingsBloc(_createCryptoStorage(), _createPgpWorker());

  _i8.CryptoStorage _createCryptoStorage() =>
      _singletonCryptoStorage ??= _cryptoModule.cryptoStorage(
          _createFlutterSecureStorage(), _createPgpKeyDao());

  _i5.FlutterSecureStorage _createFlutterSecureStorage() =>
      _singletonFlutterSecureStorage ??= _storageModule.flutterSecureStorage();

  _i7.PgpKeyDao _createPgpKeyDao() =>
      _singletonPgpKeyDao ??= _daoModule.pgpKeyDao();

  _i10.PgpWorker _createPgpWorker() => _singletonPgpWorker ??=
      _cryptoModule.pgpWorker(_createPgp(), _createCryptoStorage());

  _i9.Pgp _createPgp() => _singletonPgp ??= _cryptoModule.pgp();

  _i16.SettingsMethods _createSettingsMethods() => _logicModule.settingsMethods(
      _createAuthLocalStorage(),
      _createUsersDao(),
      _createSettingsLocalStorage(),
      _createCryptoStorage());

  _i11.AuthLocalStorage _createAuthLocalStorage() =>
      _singletonAuthLocalStorage ??= _storageModule.authLocalStorage();

  _i12.UsersDao _createUsersDao() =>
      _singletonUsersDao ??= _daoModule.userDao();

  _i13.SettingsLocalStorage _createSettingsLocalStorage() =>
      _singletonSettingsLocalStorage ??= _storageModule.settingsLocalStorage();

  @override
  _i15.PgpSettingsBloc pgpSettingsBloc() => _createPgpSettingsBloc();

  @override
  _i16.SettingsMethods settingsMethods() => _createSettingsMethods();
}
