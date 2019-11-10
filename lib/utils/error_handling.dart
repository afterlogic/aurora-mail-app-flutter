import 'dart:io';

class ServerError implements Exception {
  final String message;

  ServerError(this.message) : super();

  @override
  String toString() => message;
}

// TODO translate
String formatError(dynamic err, StackTrace stack) {
  if (err is ServerError) {
    return err.toString();
  } else if (err is SocketException) {
    if (err.osError.errorCode == 7) {
      return "Could not connect to the server";
    } else {
      return err.message.isNotEmpty ? err.message : "Unknown error";
    }
  } else {
    print("Debug error: $err");
    print("Debug stack: $stack");
    return err.toString();
    // TODO VO set unknown for release
//    return "Unknown error";
  }
}
