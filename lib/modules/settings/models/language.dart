
import 'dart:convert';

import 'package:aurora_mail/build_property.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';

class Language {
  final String? name;
  final String? tag;

  const Language(this.name, this.tag);

  // for language selection modal
  static List<Language?> get availableLanguages {
    final languages = <Language?>[];
    // null sets system default language
    languages.add(null);
    languages.addAll(BuildProperty.supportLanguage
        .split(",")
        .map((item) => Locale(item))
        .toList()
        .map((locale) {
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
      case "fr":
        return "Français";
      case "de":
        return "Deutsch";
      case 'it':
        return "Italiano";
      default:
        return "UNKNOWN_LANGUAGE";
    }
  }

  Locale? toLocale() {
    if (tag == null) return null;
    return BuildProperty.supportLanguage
        .split(",")
        .map((item) => Locale(item))
        .firstWhereOrNull((l) => l.toLanguageTag() == tag);
  }

  String? toNullableJson() {
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
    final decoded = json.decode(lang) as Map;
    return new Language(decoded["name"] as String?, decoded["tag"] as String?);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Language && other.tag == tag && other.name == name;
  }

  @override
  int get hashCode => tag.hashCode ^ name.hashCode;
}
