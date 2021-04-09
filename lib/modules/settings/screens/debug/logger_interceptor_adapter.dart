import 'package:aurora_logger/aurora_logger.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class LoggerInterceptorAdapter extends LoggerApiInterceptor {
  LoggerInterceptorAdapter(ApiInterceptor apiInterceptor) {
    apiInterceptor.onError = (msg) {
      error(msg);
    };
    apiInterceptor.onRequest = (msg) {
      request(msg);
    };
    apiInterceptor.onResponse = (msg) {
      response(msg);
    };
  }
}
