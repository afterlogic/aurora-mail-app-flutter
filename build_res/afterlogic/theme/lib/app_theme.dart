import 'package:flutter/material.dart';

class AppTheme {
  static const _appColor = const Color(0xFF6064D3);

  static final theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _appColor,
    accentColor: _appColor,
    disabledColor: Colors.black.withOpacity(0.3),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    splashFactory: InkRipple.splashFactory
  );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: _appColor,
      accentColor: _appColor,
      disabledColor: Colors.white.withOpacity(0.3),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.black,
//        iconTheme: IconThemeData(color: Colors.black),
//        actionsIconTheme: IconThemeData(color: Colors.black),
//        textTheme: TextTheme(
//          title: TextStyle(
//            color: Colors.black,
//            fontSize: 18.0,
//            fontWeight: FontWeight.w500,
//          ),
//        ),
      ),
      splashFactory: InkRipple.splashFactory
  );
}
