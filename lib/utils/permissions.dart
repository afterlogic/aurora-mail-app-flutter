
// import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Only relevant below API 29: from Android 10 (scoped storage) onward, writing
// an app's own downloaded file into public storage goes through MediaStore
// (see moveToDownloads()), which needs no runtime permission at all -- asking
// for Permission.photos (READ_MEDIA_IMAGES) here for a download-only flow was
// an unjustified broad-media-access request and got the app rejected by Play.
Future getStoragePermissions() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final androidInfo = await deviceInfo.androidInfo;

  if (androidInfo.version.sdkInt >= 29) return;

  PermissionStatus status = await Permission.storage.status;

  if (status != PermissionStatus.granted) {
    status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      throw "No permission to access the local storage. Check your device settings."; //S.no_permission_to_local_storage;
    }
  }
}

// final _channel = MethodChannel("REQUEST_STORAGE_PERMISSION");

// Future<PermissionStatus> _requestStoragePermission() async {
//   //todo fix permission_handler on android 10
//   final bool result = await _channel.invokeMethod("");
//   return result ? PermissionStatus.granted : PermissionStatus.denied;
// }
