import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/error_code.dart';
import 'package:flutter/widgets.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ErrorToShow {
  final String message;

  factory ErrorToShow(dynamic error) {
    if (error is SocketException) {
      return ErrorToShow.message(S.current.error_timeout);
    } else if (error is WebMailApiError) {
      return error.toShow();
    } else {
      if (error is ErrorToShow) {
        return error;
      }
      return ErrorToShow.message(error.toString());
    }
  }

  ErrorToShow.message(this.message);

  String getString() {
      return message;
  }

  @override
  String toString() {
    return "$message";
  }
}
