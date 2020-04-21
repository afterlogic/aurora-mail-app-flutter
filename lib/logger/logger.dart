import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      log("Api error: $str", false);
    };
    WebMailApi.onRequest = (str) {
      log("Api response: $str", false);
    };
  }

  log(Object text, [bool show = true]) {
    if (show == true) print(text);
    if (isRun) {
      buffer += "$text\n";
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
    await Crashlytics.instance.log(buffer);
    await Crashlytics.instance.recordError("record log", null);
    buffer = "";
    count = 0;
    isRun = false;
    if (onEdit != null) onEdit();
  }

  pause() {
    isRun = false;
    if (onEdit != null) onEdit();
  }
}
