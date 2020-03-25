import 'package:aurora_mail/inject/modules/crypto_module.dart';
import 'package:aurora_mail/inject/modules/dao_module.dart';
import 'package:aurora_mail/inject/modules/storage_module.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:dm/dm.dart';

import 'app_inject.dm.dart';

@Modules(const [CryptoModule, DaoModule, StorageModule])
abstract class AppInjector {
  static AppInjector instance;

  static Future create() async {
    instance = await AppInjectorImpl().init();
  }

  @provide
  PgpWorker pgpWorker();

  @provide
  CryptoStorage cryptoStorage();

  PgpSettingsBloc pgpSettingsBloc();

  SettingsMethods settingsMethods();
}
