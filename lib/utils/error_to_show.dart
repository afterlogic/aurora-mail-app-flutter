import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/error_code.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ErrorToShow {
  final String message;

  /// [stackTrace] should be passed whenever available (eg. from [formatError])
  /// so code-level errors are reported to Crashlytics with an accurate trace.
  factory ErrorToShow(dynamic error, [StackTrace? stackTrace]) {
    if (error is SocketException) {
      return ErrorToShow.message(S.current.error_timeout);
    } else if (error is WebMailApiError) {
      return error.toShow();
    } else if (error is ErrorToShow) {
      return error;
    } else if (error is String) {
      // an intentionally pre-formatted, user-facing message
      return ErrorToShow.message(error);
    } else {
      // anything else is a code-level bug (TypeError, StateError, etc.) —
      // never show it verbatim to the user, report it instead
      if (!kDebugMode) {
        FirebaseCrashlytics.instance
            .recordError(error, stackTrace ?? StackTrace.current, fatal: false);
      }
      return ErrorToShow.message(S.current.error_unknown);
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
