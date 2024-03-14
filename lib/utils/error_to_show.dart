//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/widgets.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ErrorToShow {
  final int code;
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

  ErrorToShow.code(this.code) : message = null;

  ErrorToShow.message(this.message) : code = null;

  String getString(BuildContext context, [Map<String, String> arg]) {
    if (code != null) {
      return i18n(context, code, arg);
    } else {
      return message;
    }
  }

  @override
  String toString() {
    return "$code$message";
  }
}
