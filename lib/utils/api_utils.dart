import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/error_code.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter/foundation.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

ErrorToShow formatError(dynamic err, StackTrace stack) {
  if (err is WebMailApiError) {
    return err.toShow();
  } else if (err is SocketException) {
    if (err.osError?.errorCode == 7 ||
        err.message.contains('connection timed out') == true) {
      return ErrorToShow.message(S.current.error_connection);
    } else {
      return ErrorToShow.message(
          err.message.isNotEmpty ? err.message : err.toString());
    }
  } else if (err is TypeError) {
    debugPrint("TypeError: $err Stack: $stack");
    return ErrorToShow(err);
  } else if (err is StateError) {
    debugPrint("StateError: $err Stack: $stack");
    if (err.message.contains('No element') == true) {
      return ErrorToShow.message(S.current.record_not_found);
    } else {
      return ErrorToShow(err);
    }
  } else {
    debugPrint("Debug error: $err");
    debugPrint("Debug stack: $stack");
    return ErrorToShow(err);
    // TODO set unknown for release
//    return "Unknown error";
  }
}
