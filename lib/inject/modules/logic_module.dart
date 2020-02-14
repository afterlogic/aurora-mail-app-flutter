import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:aurora_mail/modules/settings/repository/settings_local_storage.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:inject/inject.dart';

@module
//todo create this module automatically
class LogicModule {
  @provide
  PgpSettingsBloc pgpSettingsBloc(CryptoStorage storage, PgpWorker pgpWorker) =>
      PgpSettingsBloc(storage, pgpWorker);

  @provide
  SettingsMethods settingsMethods(
    AuthLocalStorage authLocalStorage,
    UsersDao usersDao,
    SettingsLocalStorage settingsLocalStorage,
    CryptoStorage cryptoStorage,
  ) =>
      SettingsMethods(
        authLocalStorage,
        usersDao,
        settingsLocalStorage,
        cryptoStorage,
      );
}
