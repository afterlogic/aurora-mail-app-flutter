//@dart=2.9
import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class DefaultApiInterceptor extends ApiInterceptor {
  static ApiInterceptor _instance;

  static ApiInterceptor get() {
    if (_instance == null) {
      _instance = ApiInterceptor();
      DebugLocalStorage().getShowResponseBody().then((showResponseBody) {
        _instance.logResponse = showResponseBody;
      });
      DebugLocalStorage().addListener(() async {
        final showResponseBody =
            await DebugLocalStorage().getShowResponseBody();
        _instance.logResponse = showResponseBody;
      });
    }
    return _instance;
  }
}
