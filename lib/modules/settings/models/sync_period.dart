import 'package:intl/intl.dart';

enum Period {
  allTime,
  months1,
  months3,
  months6,
  years1,
}

class SyncPeriod {
  static String periodToTitle(Period period) {
    switch (period) {
      // TODO translate
      case Period.allTime:
        return "all time";
      case Period.months1:
        return "1 month";
      case Period.months3:
        return "3 months";
      case Period.months6:
        return "6 months";
      case Period.years1:
        return "1 year";
      default:
        return null;
    }
  }

  static String periodToDbString(Period period) {
    if (period == Period.allTime)
      return null;
    else
      return period.toString();
  }

  static String _subtractPeriodFromNow(Duration duration) {
    return DateFormat("yyyy.MM.dd").format(DateTime.now().subtract(duration));
  }

  static String periodToDate(Period period) {
    switch (period) {
      case Period.allTime:
        return null;
      case Period.months1:
        return _subtractPeriodFromNow(Duration(days: 31));
      case Period.months3:
        return _subtractPeriodFromNow(Duration(days: 31 * 3));
      case Period.months6:
        return _subtractPeriodFromNow(Duration(days: 31 * 6));
      case Period.years1:
        return _subtractPeriodFromNow(Duration(days: 31 * 12));
      default:
        return null;
    }
  }

  static Period dbStringToPeriod(String str) {
    if (str == null) return Period.allTime;
    return Period.values.firstWhere((e) => e.toString() == str);
  }
}
