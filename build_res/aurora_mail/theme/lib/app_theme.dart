import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: AppColor.primary),
    floatingActionButtonTheme: _floatTheme,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
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
