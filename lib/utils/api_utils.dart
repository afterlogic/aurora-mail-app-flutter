//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:webmail_api_client/webmail_api_client.dart';
import 'error_code.dart';

ErrorToShow formatError(dynamic err, StackTrace stack) {
  if (err is WebMailApiError) {
    return err.toShow();
  } else if (err is SocketException) {
    if (err.osError?.errorCode == 7 ||
        err.message?.contains('connection timed out') == true) {
      return ErrorToShow.code(S.error_connection);
    } else {
      return ErrorToShow.message(
          err.message.isNotEmpty ? err.message : err.toString());
    }
  } else if (err is TypeError) {
    print("TypeError: $err Stack: $stack");
    return ErrorToShow(err);
  } else {
    print("Debug error: $err");
    print("Debug stack: $stack");
    return ErrorToShow(err);
    // TODO set unknown for release
//    return "Unknown error";
  }
}
