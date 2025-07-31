import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.primary,
    ),
    primaryColor: AppColor.primary,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        primary: AppColor.primary,
        secondary: AppColor.primary,
        background: Color(0xFFe6ebf0),
        brightness: Brightness.light),
    scaffoldBackgroundColor: Colors.white,
    disabledColor: Colors.black.withOpacity(0.4),
    splashFactory: InkRipple.splashFactory,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
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
    ),
    buttonTheme: _buttonTheme,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColor.primary),
    )),
    floatingActionButtonTheme: _floatTheme,
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColor.primary)),
    dialogTheme: _dialogTheme,
    snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        insetPadding: EdgeInsets.all(6),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.green),
  );

  static final dark = ThemeData(
    primaryColor: AppColor.primary,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        secondary: AppColor.primary,
        onPrimary: AppColor.primary,
        error: AppColor.warning,
        background: Color(0xFFe6ebf0),
        brightness: Brightness.dark),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    disabledColor: Colors.white.withOpacity(0.4),
    splashFactory: InkRipple.splashFactory,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
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
    ),
    buttonTheme: _buttonTheme,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColor.primary),
    )),
    floatingActionButtonTheme: _floatTheme,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColor.primary)),
    dialogTheme: _dialogTheme,
    snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        insetPadding: EdgeInsets.all(6),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.green),
  );

  static final ThemeData? login = null;
  static final Color? loginTextColor = null;

  static final floatIconTheme = IconThemeData(color: Colors.white);

  static final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
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
