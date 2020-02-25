import 'package:flutter/services.dart';

final _channel = MethodChannel("DIRECTORY_DOWNLOADS");

Future<String> getDownloadDirectory() async {
  return _channel.invokeMethod("");
}
