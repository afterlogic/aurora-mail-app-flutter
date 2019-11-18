import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    splashFactory: InkRipple.splashFactory,
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.blue,
    splashFactory: InkRipple.splashFactory,
  );
}
