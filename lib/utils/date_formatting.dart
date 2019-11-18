import 'package:intl/intl.dart';

class DateFormatting {
  static String formatDateFromSeconds(int timestamp, String locale,
      {String format = "MMM dd"}) {
    return DateFormat(format, locale)
        .format(DateTime.fromMillisecondsSinceEpoch((timestamp * 1000)));
  }
}
