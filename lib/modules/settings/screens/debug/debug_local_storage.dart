import 'package:shared_preferences/shared_preferences.dart';

class DebugLocalStorage {
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

}
