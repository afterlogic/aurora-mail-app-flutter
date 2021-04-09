import 'package:aurora_logger/aurora_logger.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class DefaultLoggerInterceptorAdapter extends LoggerApiInterceptor {
  DefaultLoggerInterceptorAdapter() {
    WebMailApi.onError = (msg) {
      error(msg);
    };
    WebMailApi.onRequest = (msg) {
      request(msg);
    };
    WebMailApi.onResponse = (msg) {
      response(msg);
    };
  }
}
