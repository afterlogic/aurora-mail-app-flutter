import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateFormatting {
  static String formatDateFromSeconds(
      {@required int timestamp, String format = "MMM dd"}) {
    return DateFormat(format)
        .format(DateTime.fromMillisecondsSinceEpoch((timestamp * 1000)));
  }
}
