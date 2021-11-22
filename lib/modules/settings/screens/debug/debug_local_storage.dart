import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugLocalStorage extends ChangeNotifier {
  static final DebugLocalStorage _instance = DebugLocalStorage._();

  factory DebugLocalStorage() {
    return _instance;
  }

  DebugLocalStorage._();

  static const _enableCounter = "enableCounter";

  Future setEnableCounter(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_enableCounter, enable);
    notifyListeners();
  }

  Future<bool> getEnableCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enableCounter) ?? false;
  }

  static const _backgroundRecord = "backgroundRecord";

  Future setBackgroundRecord(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_backgroundRecord, enable);
    notifyListeners();
  }

  Future<bool> getBackgroundRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_backgroundRecord) ?? false;
  }

  static const _showResponseBody = "showResponseBody";

  Future setShowResponseBody(bool enable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_showResponseBody, enable);
    notifyListeners();
  }

  Future<bool> getShowResponseBody() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showResponseBody) ?? false;
  }
}
