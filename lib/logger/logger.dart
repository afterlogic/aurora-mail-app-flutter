import 'dart:io';

import 'package:aurora_mail/modules/settings/screens/debug/debug_local_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

import '../build_property.dart';

final logger = Logger._();

class Logger {
  String currentTag;
  final storage = DebugLocalStorage();
  bool _isRun = false;

  void set isRun(bool val) {
    storage.setIsRun(val);
    _isRun = val;
  }

  bool get isRun => _isRun;
  bool _enable = false;

  bool get enable => _enable;

  set enable(bool v) {
    _enable = v;
    if (onEdit != null) onEdit();
  }

  String buffer = "";
  int count = 0;
  Function onEdit;

  Logger._([String tag, ApiInterceptor apiInterceptor]) {
    currentTag = tag;
    if (apiInterceptor != null) {
      apiInterceptor.onError = (str) {
        log("API ERROR:\n$str", true);
      };
      apiInterceptor.onRequest = (str) {
        log("API REQUEST:\n$str", true);
      };
      apiInterceptor.onResponse = (str) {
        log("API RESPONSE:\n$str", true);
      };
    } else {
      WebMailApi.onError = (str) {
        log("API ERROR:\n$str", true);
      };
      WebMailApi.onRequest = (str) {
        log("API REQUEST:\n$str", true);
      };
      WebMailApi.onResponse = (str) {
        log("API RESPONSE:\n$str", true);
      };
    }
  }

  log(Object text, [bool show = true]) {
    if (show == true) print(text);
    if (isRun) {
      buffer +=
          "[${DateFormat("hh:mm:ss.ms").format(DateTime.now())}] ${"$text".replaceAll("\n", newLine)}$newLine$newLine";
      count++;
      if (onEdit != null) onEdit();
    }
  }

  static Logger isolated(String tag, ApiInterceptor apiInterceptor) {
    return Logger._(tag, apiInterceptor);
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
      final dir = await logDir();
      final file = File(
        dir +
            Platform.pathSeparator +
            (currentTag == null ? "" : "$currentTag${Platform.pathSeparator}") +
            DateTime.now().toIso8601String() +
            ".log.txt",
      );
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

  Future<String> logDir() async {
    return (await getApplicationDocumentsDirectory()).path +
        Platform.pathSeparator +
        "Logs_${BuildProperty.packageName}";
  }

  static const newLine = "|/n|";
}
