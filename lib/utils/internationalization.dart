import 'dart:ui';

import 'package:aurora_mail/build_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

String i18n(BuildContext context, String value, [Map<String, String> params]) {
  try {
    return FlutterI18n.translate(context, value, params);
  } catch (err) {
    return "";
  }
}

final supportedLocales = BuildProperty.supportLanguage
    .split(",")
    .map((item) => Locale(item))
    .toList();
