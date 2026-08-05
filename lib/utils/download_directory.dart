

import 'package:flutter/services.dart';

final _channel = MethodChannel("DIRECTORY_DOWNLOADS");

Future<String?> getDownloadDirectory() async {
  // TODO: deal with Android 10 file permissions
  // if (Platform.isAndroid) {
  //   // for Android 10 or high
  //   if (await DeviceIdStorage.isAndroid10orHigh()) {
  //     final directory = await getExternalStorageDirectory();
  //     return directory.path;
  //   }
  // }
  return _channel.invokeMethod("");
}
