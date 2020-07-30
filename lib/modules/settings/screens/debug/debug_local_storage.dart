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
  static const _enableCounter = "enableCounter";

  Future setEnableCounter(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_enableCounter, enable);
  }

  Future<bool> getEnableCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableCounter) ?? false;
  }
  static const _backgroundRecord = "backgroundRecord";

  Future setBackgroundRecord(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_backgroundRecord, enable);
  }

  Future<bool> getBackgroundRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_backgroundRecord) ?? false;
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
