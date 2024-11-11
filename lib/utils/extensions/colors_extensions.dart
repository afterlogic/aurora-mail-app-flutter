import 'dart:ui';

import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    String formattedString = hexString.replaceAll("#", "");
    if (formattedString.length == 3) {
      formattedString = formattedString.substring(0, 1) * 2 + formattedString.substring(1, 2) * 2 + formattedString.substring(2, 3) * 2;
    } else if (formattedString.length == 4) {
      formattedString = formattedString.substring(0, 1) * 2 + formattedString.substring(1, 2) * 2 + formattedString.substring(2, 3) * 2 + formattedString.substring(3, 4) * 2;
    }

    int intValue = int.parse(formattedString, radix: 16);

    if (formattedString.length == 6) {
      return Color(intValue).withAlpha(255);
    } else if (formattedString.length == 8) {
      int alpha = intValue >> 24;
      int rgb = intValue & 0x00FFFFFF;
      return Color(rgb).withAlpha(alpha);
    } else {
      return Colors.grey;
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16)}'
      '${green.toRadixString(16)}'
      '${blue.toRadixString(16)}'
  ;
}