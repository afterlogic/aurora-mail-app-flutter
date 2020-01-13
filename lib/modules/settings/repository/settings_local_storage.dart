import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalStorage {
  final isDarkTheme = "isDarkTheme";
  final is24 = "is24";

  Future<AppSettingsSharedPrefs> getSettingsSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return AppSettingsSharedPrefs(
      isDarkTheme: prefs.getBool(isDarkTheme),
      is24: prefs.getBool(is24),
    );
  }

  Future<bool> setIsDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isDarkTheme, value);
  }

//  Future<void> deleteSettings() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.remove(isDarkTheme);
//    prefs.remove(is24);
//  }

  Future<bool> setTimeFormat(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(is24, value);
  }
}

class AppSettingsSharedPrefs {
  final bool isDarkTheme;
  final bool is24;

  const AppSettingsSharedPrefs({@required this.isDarkTheme, @required this.is24});
}
