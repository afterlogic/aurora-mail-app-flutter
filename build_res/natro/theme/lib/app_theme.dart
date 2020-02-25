import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: AppColor.primary),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    iconTheme: IconThemeData(color: AppColor.primary),
  );

  static final login = light;
}
