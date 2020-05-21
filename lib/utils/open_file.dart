import 'dart:io';

import 'package:flutter/services.dart';

class OpenFile {
  OpenFile._();

  static const MethodChannel _channel = const MethodChannel('open_file');

  static Future<bool> openFile(File file) async {
    return _channel.invokeMethod('open_file', file.path);
  }
}
