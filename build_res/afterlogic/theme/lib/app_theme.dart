import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.primary,
    ),
    primaryColor: AppColor.primary,
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColor.primary)),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColor.primary),
    )),
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
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      insetPadding: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.green
    ),
    splashFactory: InkRipple.splashFactory,
    disabledColor: Colors.black.withOpacity(0.4),
    scaffoldBackgroundColor: Colors.white,
//    iconTheme: IconThemeData(color: AppColor.primary),
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
    floatingActionButtonTheme: _floatTheme,
  );

  static final dark = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.accent,
      selectionHandleColor: AppColor.accent,
      cursorColor: AppColor.accent,
    ),
    primaryColor: AppColor.primary,
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      insetPadding: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.green
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColor.primary)),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColor.primary),
        )
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        secondary: AppColor.primary,
        onPrimary: AppColor.primary,
        error: AppColor.warning,
        background: Color(0xFFe6ebf0),
        brightness: Brightness.dark
    ),

//    iconTheme: IconThemeData(color: AppColor.primary),
    splashFactory: InkRipple.splashFactory,
    disabledColor: Colors.white.withOpacity(0.4),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
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
    floatingActionButtonTheme: _floatTheme,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
  );

  static final ThemeData? login = null;
  static final Color? loginTextColor = null;

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
