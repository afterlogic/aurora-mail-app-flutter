import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateFormatting {
  static String formatDateFromSeconds(int timestamp, String locale,
      {String format = "MMM dd"}) {
    return DateFormat(format, locale)
        .format(DateTime.fromMillisecondsSinceEpoch((timestamp * 1000)));
  }

  static String formatBirthday({
    @required int day,
    @required int month,
    @required int year,
    @required String locale,
    @required String format,
  }) {
    if (year == 0 && month == 0 && year == 0) return "";
    return DateFormat(format, locale).format(DateTime(year, month, day));
  }
}
