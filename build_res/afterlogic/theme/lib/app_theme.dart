import 'package:flutter/material.dart';

class AppTheme {
  static const _appColor = const Color(0xFF6064D3);

  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: _appColor,
    accentColor: _appColor,
    disabledColor: Colors.black.withOpacity(0.3),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      display1: TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    ),
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
        subtitle: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    splashFactory: InkRipple.splashFactory,
  );

  static final dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: _appColor,
      accentColor: _appColor,
      disabledColor: Colors.white.withOpacity(0.3),
      scaffoldBackgroundColor: Color(0xFF1A1A1A),
      textTheme: TextTheme(
        display1: TextStyle(
          color: Colors.white,
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
        color: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          subtitle: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      splashFactory: InkRipple.splashFactory
  );
}
