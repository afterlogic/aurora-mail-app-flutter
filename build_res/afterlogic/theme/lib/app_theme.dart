import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'login_form_style.dart';

export 'login_form_style.dart';

class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      surface: Color(0xFFe6ebf0),
      error: AppColor.warning,
    ),
    primaryColor: AppColor.primary,
    disabledColor: Colors.black.withValues(alpha: 0.4),
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
    dividerColor: AppColor.divider,
    dividerTheme: const DividerThemeData(color: AppColor.divider),
    extensions: <ThemeExtension<dynamic>>[_loginFormLight],
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      surface: Color(0xFF1A1A1A),
      error: AppColor.warning,
    ),
    primaryColor: AppColor.primary,
    disabledColor: Colors.white.withValues(alpha: 0.4),
    scaffoldBackgroundColor: Color(0xFF1A1A1A),
    splashFactory: InkRipple.splashFactory,
    appBarTheme: _appBarThemeDark,
    bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
    bottomAppBarTheme: BottomAppBarThemeData(color: Colors.black),
    buttonTheme: _buttonTheme,
    dialogTheme: _dialogTheme,
    floatingActionButtonTheme: _fabTheme,
    inputDecorationTheme: _inputDecorationThemeDark,
    snackBarTheme: _snackBarTheme,
    textButtonTheme: _textButtonTheme,
    textTheme: _textThemeDark,
    textSelectionTheme: _textSelectionTheme,
    dividerColor: AppColor.dividerDark,
    dividerTheme: const DividerThemeData(color: AppColor.dividerDark),
    extensions: <ThemeExtension<dynamic>>[_loginFormDark],
  );

  static final floatIconTheme = IconThemeData(color: Colors.white);
  static final ThemeData? login = null;
  static final Color? loginTextColor = null;
  static final buttonRadius = BorderRadius.circular(40.0);
  static final buttonColor = AppColor.primaryVariant;
  static final buttonShadow = const BoxShadow();

  // Card not shown for this brand
  static final loginCardDecorationLight = const BoxDecoration();
  static final loginCardDecorationDark = const BoxDecoration();
  static final loginCardPadding = const EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 36.0,
  );

  // Sign-in form appearance (card + input fields). Registered in
  // `light`/`dark` via `extensions:` and consumed by the login screen and
  // `AuthInput`. This brand keeps a flat card.
  static final _loginFormLight = LoginFormStyle(
    // Keep visually in sync with `splashGradientTop/Bottom` in
    // build_variant.yaml so the native Android splash blends into the
    // Flutter login screen.
    screenBackground: const BoxDecoration(color: Color(0xFFFFFFFF)),
    cardMargin: const EdgeInsets.symmetric(horizontal: 22.0),
    cardPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36.0),
    cardMaxWidth: 450.0,
    cardDecoration: const BoxDecoration(),
    titleTextStyle: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    fieldFillColor: Colors.white.withValues(alpha: 0.5),
    fieldContentPadding:
        const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    fieldRadius: 10.0,
    fieldBorderColor: const Color(0xFFEBEBEB),
    fieldFocusedBorderColor: const Color(0xFF1D67CD),
    fieldErrorBorderColor: AppColor.warning,
    fieldTextStyle: const TextStyle(color: Colors.black87),
    fieldHintStyle: const TextStyle(color: Color(0xFFA6ACB8)),
  );

  static final _loginFormDark = LoginFormStyle(
    // Keep visually in sync with `splashGradientTopDark/BottomDark` in
    // build_variant.yaml.
    screenBackground: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.5],
        colors: [Color(0xFF1F3042), Color(0xFF111111)],
      ),
    ),
    cardMargin: const EdgeInsets.symmetric(horizontal: 22.0),
    cardPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36.0),
    cardMaxWidth: 450.0,
    cardDecoration: const BoxDecoration(),
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.white54,
    ),
    fieldFillColor: Colors.white.withValues(alpha: 0.15),
    fieldContentPadding:
        const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    fieldRadius: 10.0,
    fieldBorderColor: Colors.white.withValues(alpha: 0.20),
    fieldFocusedBorderColor: const Color(0xFF1D67CD),
    fieldErrorBorderColor: AppColor.warning,
    fieldTextStyle: const TextStyle(color: Colors.white70),
    fieldHintStyle: const TextStyle(color: Color(0xFFA6ACB8)),
  );

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

  static final _dialogTheme = DialogThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.appBarText, // Using text color from AppColor
    ),
  );

  static final _fabTheme = FloatingActionButtonThemeData(
    hoverColor: AppColor.accent.withValues(alpha: 0.8),
    backgroundColor: AppColor.accent,
  );

  static final _inputDecorationThemeLight = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: AppColor.primary),
    filled: true,
    fillColor: Colors.white,
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
      foregroundColor: WidgetStateProperty.all(AppColor.primary),
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
