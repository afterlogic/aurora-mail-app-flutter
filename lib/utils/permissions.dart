import 'dart:io';

import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future getStoragePermissions() async {
  PermissionStatus status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    status = await Permission.storage.request();
    // (Platform.isAndroid
    //     ? _requestStoragePermission()
    //     : Permission.storage.request());
    if (status != PermissionStatus.granted) {
      throw S.no_permission_to_local_storage;
    }
  }
}

final _channel = MethodChannel("REQUEST_STORAGE_PERMISSION");

Future<PermissionStatus> _requestStoragePermission() async {
  //todo fix permission_handler on android 10
  final bool result = await _channel.invokeMethod("");
  return result ? PermissionStatus.granted : PermissionStatus.denied;
}
