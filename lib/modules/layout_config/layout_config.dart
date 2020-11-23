import 'package:flutter/cupertino.dart';

class LayoutConfig {
  final bool isTablet;
  static const formWidth = 450.0;

  final int columnCount;

  LayoutConfig(this.isTablet, this.columnCount);

  static LayoutConfig of(BuildContext context) {
    var media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;

    return LayoutConfig(
      isTablet,
      media.size.width ~/ 304,
    );
  }
}
