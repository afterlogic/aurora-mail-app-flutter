import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/settings/repository/settings_local_storage.dart';
import 'package:dm/dm.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageModule {
  @Provide()
  FlutterSecureStorage flutterSecureStorage() => FlutterSecureStorage();

  @Provide()
  SettingsLocalStorage settingsLocalStorage() => SettingsLocalStorage();

  @Provide()
  AuthLocalStorage authLocalStorage() => AuthLocalStorage();
}
