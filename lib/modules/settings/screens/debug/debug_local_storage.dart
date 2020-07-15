import 'package:shared_preferences/shared_preferences.dart';

class DebugLocalStorage {
  static const _debug = "debug";

  Future setDebug(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_debug, enable);
  }

  Future<bool> getDebug() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_debug) ?? false;
  }

  static const _isRun = "isRun";

  Future setIsRun(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isRun, enable);
  }

  Future<bool> getIsRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRun) ?? false;
  }
}
