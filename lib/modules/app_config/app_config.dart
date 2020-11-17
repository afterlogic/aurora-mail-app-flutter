import 'package:flutter/cupertino.dart';

class AppConfig {
  final bool isTablet;

  AppConfig(this.isTablet);

  static AppConfig of(BuildContext context) {
    return AppConfig(
      _isTablet(context),
    );
  }

  static bool _isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }
}
