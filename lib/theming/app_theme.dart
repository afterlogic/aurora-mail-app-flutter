import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
//    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
//    primaryColor: Color(0xFFe95052),
//    accentColor: Color(0xFF43cebe),
    splashFactory: InkRipple.splashFactory,
  );
}
