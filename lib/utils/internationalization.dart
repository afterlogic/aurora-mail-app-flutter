import 'dart:ui';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/res/str/en_s.dart';
import 'package:flutter/cupertino.dart';
import 'package:localizator_interface/localizator_interface.dart';

export 'error_code.dart';

String i18n(BuildContext context, int value, [Map<String, String> params]) {
  try {
    var string = Localizations.of<SInterface>(context, SInterface).get(value);
    if (string == null) {
      string = _default.get(value);
    }
    if (params != null) {
      string = _replaceParams(string, params);
    }
    return string;
  } catch (err) {
    return "";
  }
}

final _default = EnS();

String _replaceParams(
    String translation, final Map<String, String> translationParams) {
  for (final String paramKey in translationParams.keys) {
    translation = translation.replaceAll(
        new RegExp('{$paramKey}'), translationParams[paramKey]);
  }
  return translation;
}

final supportedLocales = BuildProperty.supportLanguage
    .split(",")
    .map((item) => Locale(item))
    .toList();
