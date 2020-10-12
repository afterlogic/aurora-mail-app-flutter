import 'dart:math';

import 'package:flutter/services.dart';

class HostInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp("\. +"), ".");
    final offset = newValue.text.length - text.length;
    return newValue.copyWith(
      text: text,
      selection: newValue.selection.copyWith(
        baseOffset: max(newValue.selection.baseOffset - offset, 0),
        extentOffset: max(newValue.selection.baseOffset - offset, 0),
      ),
      composing: TextRange.collapsed(max(newValue.composing.end - offset, 0)),
    );
  }
}
