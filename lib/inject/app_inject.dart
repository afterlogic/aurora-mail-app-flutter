import 'package:aurora_mail/inject/modules/crypto_module.dart';
import 'package:aurora_mail/inject/modules/dao_module.dart';
import 'package:aurora_mail/inject/modules/logic_module.dart';
import 'package:aurora_mail/inject/modules/storage_module.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/settings_methods.dart';
import 'package:crypto_storage/crypto_storage.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:inject/inject.dart';

import 'app_inject.inject.dart' as g;

@Injector(const [CryptoModule, DaoModule, StorageModule, LogicModule])
abstract class AppInjector {
  static AppInjector instance;

  static Future create() async {
    instance = await g.AppInjector$Injector.create(
      CryptoModule(),
      DaoModule(),
      StorageModule(),
      LogicModule(),
    );
  }

  CryptoStorage cryptoStorage();

  PgpWorker pgpWorker();

  PgpSettingsBloc pgpSettingsBloc();

  SettingsMethods settingsMethods();
}
