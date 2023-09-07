import 'dart:convert';

import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/cupertino.dart';

class Language {
  final String name;
  final String tag;

  const Language(this.name, this.tag);

  // for language selection modal
  static List<Language> get availableLanguages {
    final languages = new List<Language>();
    // null sets system default language
    languages.add(null);
    languages.addAll(supportedLocales.map((locale) {
      final tag = locale.toLanguageTag();
      return new Language(_getNameFromTag(tag), tag);
    }));
    return languages;
  }

  static String _getNameFromTag(String tag) {
    switch (tag) {
      case "ru":
        return "Русский";
      case "en":
        return "English";
      case "tr":
        return "Türkçe";
      default:
        return "UNKNOWN_LANGUAGE";
    }
  }

  Locale toLocale() {
    return supportedLocales.firstWhere((l) => l.toLanguageTag() == tag,
        orElse: () {
      throw "Language $tag is not supported";
    });
  }

  String toNullableJson() {
    if (tag == null) {
      return null;
    } else {
      return json.encode({
        "name": name,
        "tag": tag,
      });
    }
  }

  static Language fromJson(String lang) {
    if (lang == null) {
      return null;
    } else {
      final decoded = json.decode(lang) as Map;
      return new Language(decoded["name"] as String, decoded["tag"] as String);
    }
  }
}
