import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    textSelectionColor: AppColor.accent,
    textSelectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: AppColor.primary),
    floatingActionButtonTheme: _floatTheme,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    textSelectionColor: AppColor.accent,
    textSelectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: AppColor.primary),
    floatingActionButtonTheme: _floatTheme,
  );

  static final login = light;

  static final _floatTheme = FloatingActionButtonThemeData(
    hoverColor: AppColor.accent.withOpacity(0.8),
    backgroundColor: AppColor.accent,
  );
}
