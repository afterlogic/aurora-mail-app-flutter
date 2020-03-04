import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: AppColor.primary,
    textSelectionColor: AppColor.accent,
    textSelectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
    accentColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
    disabledColor: Colors.black.withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: AppColor.primary),
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
    floatingActionButtonTheme: _floatTheme,
  );

  static final dark = ThemeData(
    textSelectionColor: AppColor.colorLight,
    textSelectionHandleColor: AppColor.colorLight,
    cursorColor: AppColor.colorLight,
    primaryColor: AppColor.colorLight,
    accentColor: AppColor.colorLight,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    iconTheme: IconThemeData(color: AppColor.colorLight),
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
    disabledColor: Colors.white.withOpacity(0.4),
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      hoverColor: AppColor.colorLight.withOpacity(0.2),
      backgroundColor: AppColor.accent,
    ),
    bottomAppBarColor: Colors.black,
  );

  static final login = light;

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  static final _buttonTheme = ButtonThemeData(
    buttonColor: AppColor.accent,
    textTheme: ButtonTextTheme.primary,
  );

  static final _floatTheme = FloatingActionButtonThemeData(
    hoverColor: AppColor.accent.withOpacity(0.5),
    backgroundColor: AppColor.accent,
  );
}
