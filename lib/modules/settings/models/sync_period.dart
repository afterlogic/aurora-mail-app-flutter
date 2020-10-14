import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

enum Period {
  allTime,
  months1,
  months3,
  months6,
  years1,
}

class SyncPeriod {
  static String periodToTitle(BuildContext context, Period period) {
    switch (period) {
      case Period.allTime:
        return i18n(context, S.settings_sync_period_all_time);
      case Period.months1:
        return i18n(context, S.settings_sync_period_months1);
      case Period.months3:
        return i18n(context, S.settings_sync_period_months3);
      case Period.months6:
        return i18n(context, S.settings_sync_period_months6);
      case Period.years1:
        return i18n(context, S.settings_sync_period_years1);
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

  static String subtractPeriodFromNow(Duration duration) {
    return DateFormat("yyyy.MM.dd").format(DateTime.now().subtract(duration));
  }

  static String periodToDate(Period period) {
    switch (period) {
      case Period.allTime:
        return null;
      case Period.months1:
        return subtractPeriodFromNow(Duration(days: 31));
      case Period.months3:
        return subtractPeriodFromNow(Duration(days: 31 * 3));
      case Period.months6:
        return subtractPeriodFromNow(Duration(days: 31 * 6));
      case Period.years1:
        return subtractPeriodFromNow(Duration(days: 31 * 12));
      default:
        return null;
    }
  }

  static Period dbStringToPeriod(String str) {
    if (str == null) return Period.allTime;
    return Period.values.firstWhere((e) => e.toString() == str);
  }
}
