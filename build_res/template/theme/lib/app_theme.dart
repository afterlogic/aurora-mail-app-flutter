import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: AppColor.primary,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    accentColor: AppColor.accent,
    buttonColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    selectedRowColor: Color(0xFFe2e7ec),
    backgroundColor: Color(0xFFe6ebf0),
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.light,
    disabledColor: Colors.black.withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
//    iconTheme: IconThemeData(color: AppColor.primary),
    textTheme: TextTheme(
      headline4: TextStyle(
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
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        subtitle2: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    floatingActionButtonTheme: _floatTheme,
    toggleableActiveColor: AppColor.primary,
  );

  static final dark = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    primaryColor: AppColor.primary,
    accentColor: AppColor.accent,
    buttonColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    selectedRowColor: Colors.black,
    backgroundColor: Color(0xFFe6ebf0),
//    iconTheme: IconThemeData(color: AppColor.primary),
    splashFactory: InkRipple.splashFactory,
    brightness: Brightness.dark,
    disabledColor: Colors.white.withOpacity(0.4),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    textTheme: TextTheme(
      headline4: TextStyle(
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
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    floatingActionButtonTheme: _floatTheme,
    bottomAppBarColor: Colors.black,
    toggleableActiveColor: AppColor.primary,
  );

  static final ThemeData login = null;
  static final Color loginTextColor = null;

  static final floatIconTheme = IconThemeData(color: Colors.white);

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  );

  static final _buttonTheme = ButtonThemeData(
    buttonColor: AppColor.accent,
    textTheme: ButtonTextTheme.primary,
  );

  static final _floatTheme = FloatingActionButtonThemeData(
    hoverColor: AppColor.accent.withOpacity(0.8),
    backgroundColor: AppColor.accent,
  );
}
