import 'dart:convert';

import 'package:aurora_mail/models/app_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalStorage {
  final isDarkTheme = "isDarkTheme";
  final is24 = "is24";
  final language = "language";
  final appData = "appData";

  Future<bool> setAppData(AppData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(appData, jsonEncode(data.toMap()));
  }

  Future<AppData?> getAppData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedString = prefs.getString(appData);

    return encodedString == null ? null : AppData.fromMap(
        jsonDecode(encodedString) as Map<String, dynamic>);
  }

  Future<AppSettingsSharedPrefs> getSettingsSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return AppSettingsSharedPrefs(
      isDarkTheme: prefs.getBool(isDarkTheme) ?? false,
      is24: prefs.getBool(is24) ?? true,
    );
  }

  Future<bool> setIsDarkTheme(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value == null
        ? prefs.remove(isDarkTheme)
        : prefs.setBool(isDarkTheme, value);
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

  void setLanguage(String languageString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(language, languageString);
  }

  Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(language);
  }
}

class AppSettingsSharedPrefs {
  final bool isDarkTheme;
  final bool is24;

  const AppSettingsSharedPrefs(
      {required this.isDarkTheme, required this.is24});
}
