import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      background: Color(0xFFe6ebf0),
      error: AppColor.warning,
    ),
    primaryColor: AppColor.primary,
    disabledColor: Colors.black.withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
    splashFactory: InkRipple.splashFactory,
    appBarTheme: _appBarThemeLight,
    bottomNavigationBarTheme: _bottomNavigationBarThemeLight,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    floatingActionButtonTheme: _fabTheme,
    inputDecorationTheme: _inputDecorationThemeLight,
    progressIndicatorTheme: _progressIndicatorTheme,
    snackBarTheme: _snackBarTheme,
    textButtonTheme: _textButtonTheme,
    textTheme: _textThemeLight,
    textSelectionTheme: _textSelectionTheme,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      background: Color(0xFF1A1A1A),
      error: AppColor.warning,
    ),
    primaryColor: AppColor.primary,
    disabledColor: Colors.white.withOpacity(0.4),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    splashFactory: InkRipple.splashFactory,
    appBarTheme: _appBarThemeDark,
    bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    floatingActionButtonTheme: _fabTheme,
    inputDecorationTheme: _inputDecorationThemeDark,
    snackBarTheme: _snackBarTheme,
    textButtonTheme: _textButtonTheme,
    textTheme: _textThemeDark,
    textSelectionTheme: _textSelectionTheme,
  );

  static final floatIconTheme = IconThemeData(color: Colors.white);
  static final ThemeData? login = null;
  static final Color? loginTextColor = null;

  static final _appBarThemeLight = AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.bottomNavigationBackground,
    ),
    backgroundColor: AppColor.appBarBackground,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ).titleLarge,
    toolbarTextStyle: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ).bodyMedium,
  );

  static final _appBarThemeDark = AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColor.bottomNavigationBackgroundDark,
    ),
    backgroundColor: AppColor.appBarBackgroundDark,
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ).titleLarge,
    toolbarTextStyle: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    ).bodyMedium,
  );

  static final _bottomNavigationBarThemeLight = BottomNavigationBarThemeData(
    backgroundColor: AppColor.bottomNavigationBackground,
  );

  static final _bottomNavigationBarThemeDark = BottomNavigationBarThemeData(
    backgroundColor: AppColor.bottomNavigationBackgroundDark,
  );

  static final _buttonTheme = ButtonThemeData(
    buttonColor: AppColor.accent,
    textTheme: ButtonTextTheme.primary,
  );

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.appBarText, // Using text color from AppColor
    ),
  );

  static final _fabTheme = FloatingActionButtonThemeData(
    hoverColor: AppColor.accent.withOpacity(0.8),
    backgroundColor: AppColor.accent,
  );

  static final _inputDecorationThemeLight = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: AppColor.primary),
    filled: true,
    fillColor: AppColor.inputBackground,
  );

  static final _inputDecorationThemeDark = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: AppColor.primary),
    filled: true,
    fillColor: Colors.transparent,
  );

  static final _progressIndicatorTheme = ProgressIndicatorThemeData(
    color: AppColor.primary,
  );

  static final _snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    insetPadding: EdgeInsets.all(6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: Colors.green,
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColor.primary),
    ),
  );

  static final _textThemeLight = TextTheme(
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static final _textThemeDark = TextTheme(
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static final _textSelectionTheme = TextSelectionThemeData(
    selectionColor: AppColor.accent,
    selectionHandleColor: AppColor.accent,
    cursorColor: AppColor.accent,
  );
}
