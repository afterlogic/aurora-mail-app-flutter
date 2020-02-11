import 'package:flutter/material.dart';

class AppTheme {
  static const _appColor = const Color(0xFF6064D3);

  static final theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: _appColor,
    disabledColor: Colors.black.withOpacity(0.3),
    scaffoldBackgroundColor: Colors.white,
    splashFactory: InkRipple.splashFactory
  );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: _appColor,
      disabledColor: Colors.white.withOpacity(0.3),
      splashFactory: InkRipple.splashFactory
  );
}
