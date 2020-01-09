import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalStorage {
  final isDarkTheme = "isDarkTheme";

  Future<bool> getIsDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isDarkTheme);
  }

  Future<bool> setIsDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isDarkTheme, value);
  }

  Future<bool> deleteIsDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(isDarkTheme);
  }
}
