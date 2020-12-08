import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';

class TrustDeviceMethods {
  final _authApi = new AuthApi();

  Future trustDevice(
    String login,
    String password,
    User user,
  ) async {
    final deviceId = await DeviceIdStorage.getDeviceId();
    final deviceName = await DeviceIdStorage.getDeviceName();
    return _authApi.trustDevice(
      deviceId,
      deviceName,
      user.hostname,
      login,
      password,
      user.token,
    );
  }
}
