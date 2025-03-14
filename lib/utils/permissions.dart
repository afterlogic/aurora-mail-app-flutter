//@dart=2.9
// import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future getStoragePermissions() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final androidInfo = await deviceInfo.androidInfo;

  if (androidInfo.version.sdkInt >= 33) {
    PermissionStatus status = await Permission.photos.status;

    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();

      if (status != PermissionStatus.granted) {
        throw "No permission to access the local storage. Check your device settings."; //S.no_permission_to_local_storage;
      }
    }
  } else {
    PermissionStatus status = await Permission.storage.status;

    if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        throw "No permission to access the local storage. Check your device settings."; //S.no_permission_to_local_storage;
      }
    }
  }
}

// final _channel = MethodChannel("REQUEST_STORAGE_PERMISSION");

// Future<PermissionStatus> _requestStoragePermission() async {
//   //todo fix permission_handler on android 10
//   final bool result = await _channel.invokeMethod("");
//   return result ? PermissionStatus.granted : PermissionStatus.denied;
// }
