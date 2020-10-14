class WebMailApiError implements Exception {
  final String message;
  final int code;

  factory WebMailApiError(dynamic error) {
    final msg = _getErrMsg(error);
    if (msg is int) {
      return WebMailApiError.code(msg);
    } else if (msg is String) {
      return WebMailApiError.message(msg);
    }
    return WebMailApiError.errorUnknown();
  }

  WebMailApiError.message(this.message) : code = null;

  WebMailApiError.errorUnknown() // error_unknown
      : code = null,
        message = null;

  WebMailApiError.code(this.code) : message = null;

  @override
  String toString() => "$code$message";

  static dynamic _getErrMsg(dynamic err) {
    if (err is Map) {
      if (err["ErrorMessage"] is String) {
        return err["ErrorMessage"] as String;
      } else if (err["ErrorCode"] is int) {
        return err["ErrorCode"] as int;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
