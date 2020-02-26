import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

String i18n(BuildContext context, String value, [Map<String, String> params]) {
  try {
    return FlutterI18n.translate(context, value, params);
  } catch (err) {
    return "";
  }
}

const supportedLocales = [Locale('en'), Locale('ru'), Locale('tr')];
