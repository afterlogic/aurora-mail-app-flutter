class WebMailApiError implements Exception {
  final String message;
  final int code;

  factory WebMailApiError(dynamic error) {
    final msg = _getErrMsg(error);
    final code = _getErrCode(error);
    if (msg != null || code != null) {
      return WebMailApiError.fill(msg, code);
    }
    return WebMailApiError.errorUnknown();
  }

  WebMailApiError.fill(this.message, this.code);

  WebMailApiError.message(this.message) : code = null;

  WebMailApiError.errorUnknown() // error_unknown
      : code = null,
        message = null;

  WebMailApiError.code(this.code) : message = null;

  @override
  String toString() => "$code$message";

  static String _getErrMsg(dynamic err) {
    if (err is Map) {
      if (err["ErrorMessage"] is String) {
        return err["ErrorMessage"] as String;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static int _getErrCode(dynamic err) {
    if (err is Map) {
      if (err["ErrorCode"] is int) {
        return err["ErrorCode"] as int;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
