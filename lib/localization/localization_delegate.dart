import 'package:aurora_mail/res/str/en_s.dart';
import 'package:aurora_mail/res/str/ru_s.dart';
import 'package:aurora_mail/res/str/tr_s.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/widgets.dart';
import 'package:localizator_interface/localizator_interface.dart';

class LocalizationI18nDelegate extends LocalizationsDelegate<SInterface> {
  final bool useCountryCode = false;
  final Locale forcedLocale;

  LocalizationI18nDelegate({this.forcedLocale});

  @override
  bool isSupported(final Locale locale) {
    return supportedLocales.firstWhere(
          (element) => locale.languageCode == element.languageCode,
          orElse: () => null,
        ) !=
        null;
  }

  @override
  Future<SInterface> load(final Locale locale) async {
    if (locale.languageCode.contains("ru")) {
      return RuS();
    } else if (locale.languageCode.contains("tr")) {
      return TrS();
    } else if (locale.languageCode.contains("en")) {
      return EnS();
    } else {
      return EnS();
    }
  }

  @override
  bool shouldReload(LocalizationI18nDelegate old) {
    return forcedLocale != old.forcedLocale;
  }
}
