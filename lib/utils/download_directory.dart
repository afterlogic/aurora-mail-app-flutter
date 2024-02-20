//@dart=2.9
import 'dart:io';

import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

final _channel = MethodChannel("DIRECTORY_DOWNLOADS");

Future<String> getDownloadDirectory() async {
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
