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
    brightness: Brightness.light,
    backgroundColor: Color(0xFFe6ebf0),
    scaffoldBackgroundColor: Colors.white,
    selectedRowColor: Color(0xFFe2e7ec),
    disabledColor: Colors.black.withOpacity(0.4),
    splashFactory: InkRipple.splashFactory,
    toggleableActiveColor: AppColor.primary,
    // iconTheme: IconThemeData(color: AppColor.primary),
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
    buttonColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    floatingActionButtonTheme: _floatTheme,
    dialogTheme: _dialogTheme,
  );

  static final dark = ThemeData(
    primaryColor: AppColor.primary,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    accentColor: AppColor.accent,
    brightness: Brightness.dark,
    backgroundColor: Color(0xFFe6ebf0),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    selectedRowColor: Colors.black,
    disabledColor: Colors.white.withOpacity(0.4),
    splashFactory: InkRipple.splashFactory,
    toggleableActiveColor: AppColor.primary,
    // iconTheme: IconThemeData(color: AppColor.primary),
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
    buttonColor: AppColor.accent,
    buttonTheme: _buttonTheme,
    floatingActionButtonTheme: _floatTheme,
    bottomAppBarColor: Colors.black,
    dialogTheme: _dialogTheme,
  );

  static final ThemeData? login = null;
  static final Color? loginTextColor = null;

  static final floatIconTheme = IconThemeData(color: Colors.white);

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColor.appBarText, // Using text color from AppColor
    ),
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
