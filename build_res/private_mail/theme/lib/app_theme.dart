import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    textSelectionColor: AppColor.accent,
    textSelectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
    colorScheme: ColorScheme.light(primary: AppColor.primary),
    primaryColor: AppColor.primary,
    accentColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
    disabledColor: Colors.black.withOpacity(0.6),
    floatingActionButtonTheme: _floatTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      display1: TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(color: AppColor.primary),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: AppColor.primary,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
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
        body1: TextStyle(
          color: Colors.white,
        ),
        display1: TextStyle(
          color: Colors.white54,
        ),
      ),
    ),
  );

  static final dark = ThemeData(
    textSelectionColor: AppColor.accent,
    textSelectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
    colorScheme: ColorScheme.dark(primary: AppColor.primary),
    primaryColor: AppColor.primary,
    accentColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
    floatingActionButtonTheme: _floatTheme,
    disabledColor: Colors.white.withOpacity(0.6),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    textTheme: TextTheme(
      display1: TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: AppColor.primary,
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
        body1: TextStyle(
          color: Colors.white,
        ),
        display1: TextStyle(
          color: Colors.white54,
        ),
      ),
    ),
    bottomAppBarColor: Colors.black,
  );

  static final login = dark;

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  static final _buttonTheme = ButtonThemeData(
    buttonColor: AppColor.accent,
    textTheme: ButtonTextTheme.primary,
  );

  static final _floatTheme = FloatingActionButtonThemeData(
    hoverColor: Colors.black26,
    backgroundColor: AppColor.accent,
  );
}
