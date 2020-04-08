// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ManagerGenerator
// **************************************************************************

import 'package:aurora_mail/inject/modules/crypto_module.dart';
import 'package:aurora_mail/inject/modules/dao_module.dart';
import 'package:aurora_mail/inject/modules/storage_module.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:crypto_storage/src/pgp_storage.dart';
import 'package:crypto_worker/src/pgp/pgp_worker.dart';
import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aurora_mail/modules/settings/repository/settings_local_storage.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';

class AppInjectorImpl extends AppInjector {
  final _cryptoModule = CryptoModule();
  final _daoModule = DaoModule();
  final _storageModule = StorageModule();

  CryptoStorage _cryptoStorage;
  PgpWorker _pgpWorker;
  PgpKeyDao _pgpKeyDao;
  UsersDao _usersDao;
  ContactsDao _contactsDao;
  FlutterSecureStorage _flutterSecureStorage;
  SettingsLocalStorage _settingsLocalStorage;
  AuthLocalStorage _authLocalStorage;

  Future<AppInjector> init() async {
    return this;
  }

  CryptoStorage get _getCryptoStorage => _cryptoStorage ??= _cryptoModule
      .cryptoStorage(_getFlutterSecureStorage, _getPgpKeyDao, _getContactsDao);
  PgpWorker get _getPgpWorker =>
      _pgpWorker ??= _cryptoModule.pgpWorker(_getCryptoStorage);
  PgpKeyDao get _getPgpKeyDao => _pgpKeyDao ??= _daoModule.pgpKeyDao();
  UsersDao get _getUsersDao => _usersDao ??= _daoModule.userDao();
  ContactsDao get _getContactsDao => _contactsDao ??= _daoModule.contactsDao();
  FlutterSecureStorage get _getFlutterSecureStorage =>
      _flutterSecureStorage ??= _storageModule.flutterSecureStorage();
  SettingsLocalStorage get _getSettingsLocalStorage =>
      _settingsLocalStorage ??= _storageModule.settingsLocalStorage();
  AuthLocalStorage get _getAuthLocalStorage =>
      _authLocalStorage ??= _storageModule.authLocalStorage();

  PgpWorker pgpWorker() => _getPgpWorker;
  CryptoStorage cryptoStorage() => _getCryptoStorage;
  PgpSettingsBloc pgpSettingsBloc(
    AuthBloc authBloc,
  ) =>
      PgpSettingsBloc(
        _getCryptoStorage,
        _getPgpWorker,
        authBloc,
      );
  SettingsMethods settingsMethods() => SettingsMethods(
        _getAuthLocalStorage,
        _getUsersDao,
        _getSettingsLocalStorage,
        _getCryptoStorage,
      );
}
