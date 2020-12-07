import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';

class BackupCodeMethods {
  final _authApi = new AuthApi();

  Future<User> verifyCode(
      String code, String host, String login, String password) {
    return _authApi.verifyCode(host, code, login, password);
  }
}
