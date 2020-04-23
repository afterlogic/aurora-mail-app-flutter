import 'dart:io';

import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

final logger = _Logger();

class _Logger {
  bool isRun = false;
  bool _enable = false;

  bool get enable => _enable;

  set enable(bool v) {
    _enable = v;
    if (onEdit != null) onEdit();
  }

  String buffer = "";
  int count = 0;
  Function onEdit;

  _Logger() {
    WebMailApi.onError = (str) {
      log("Api error:\n$str", false);
    };
    WebMailApi.onRequest = (str) {
      log("Api request:\n$str", true);
    };
  }

  log(Object text, [bool show = true]) {
    if (show == true) print(text);
    if (isRun) {

      buffer += "[${DateFormat("hh:mm:ss.ms").format(DateTime.now())}] ${"$text".replaceAll("\n", newLine)}$newLine$newLine";
      count++;
      if (onEdit != null) onEdit();
    }
  }

  start() {
    isRun = true;
    if (onEdit != null) onEdit();
  }

  clear() {
    buffer = "";
    count = 0;
    isRun = false;
    if (onEdit != null) onEdit();
  }

  save() async {
//    await Crashlytics.instance.log(buffer);
//    await Crashlytics.instance.recordError("record log", null);
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      await getStoragePermissions();
      final dir = (await getDownloadDirectory());
      final file = File(dir +
          Platform.pathSeparator +
          "Logs_${packageInfo.packageName}" +
          Platform.pathSeparator +
          DateTime.now().toIso8601String() +
          ".log.txt");
      await file.create(recursive: true);
      await file.writeAsString(buffer.replaceAll(newLine, "\n"));
    } catch (e) {
      e;
    }
    buffer = "";
    count = 0;
    isRun = false;
    if (onEdit != null) onEdit();
  }

  pause() {
    isRun = false;
    if (onEdit != null) onEdit();
  }

  static const newLine = "|/n|";
}
