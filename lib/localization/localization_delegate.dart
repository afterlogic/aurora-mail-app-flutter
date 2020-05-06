import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LocalizationI18nDelegate extends LocalizationsDelegate<FlutterI18n> {
  final bool useCountryCode = false;
  final String fallbackFile = "en";
  final String path = "assets/flutter_i18n";
  final Locale forcedLocale;
  static FlutterI18n _currentTranslationObject;

  LocalizationI18nDelegate({this.forcedLocale});

  @override
  bool isSupported(final Locale locale) {
    return true;
  }

  @override
  Future<FlutterI18n> load(final Locale locale) async {
    if (LocalizationI18nDelegate._currentTranslationObject == null ||
        LocalizationI18nDelegate._currentTranslationObject.locale != locale) {
      LocalizationI18nDelegate._currentTranslationObject = FlutterI18n(
          useCountryCode, fallbackFile, path, this.forcedLocale ?? locale);
      await LocalizationI18nDelegate._currentTranslationObject.load();
    }
    return LocalizationI18nDelegate._currentTranslationObject;
  }

  @override
  bool shouldReload(final LocalizationsDelegate old) {
    return _currentTranslationObject == null ||
        _currentTranslationObject.forcedLocale == null;
  }
}
