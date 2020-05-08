import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbols.dart';

class DataFormatDelegate extends LocalizationsDelegate {
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future load(Locale locale) async {
    initializeDateFormatting();
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }

  initializeDateFormatting() {
    // example
//    final symbols = Map.from(dateTimeSymbolMap())["ru"] as DateSymbols;
//    final pattern = Map<String, String>.from(dateTimePatternMap()["tr"] as Map);
//    symbols.NAME = "tr";
//    initializeDateFormattingCustom(
//      locale: "tr",
//      symbols: symbols,
//      patterns: pattern,
//    );
  }
}
