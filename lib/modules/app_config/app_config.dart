import 'package:flutter/cupertino.dart';

class AppConfig {
  final bool isTablet;
  static const formWidth = 450.0;

  AppConfig(this.isTablet);

  static AppConfig of(BuildContext context) {
    var media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;

    return AppConfig(
      isTablet,
    );
  }
}
