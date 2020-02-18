import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';

class TwoFactorMethods {
  final _authApi = new AuthApi();

  Future<User> verifyPin(
      String pin, String host, String login, String password) {
    return _authApi.verifyPin(host, pin, login, password);
  }
}
