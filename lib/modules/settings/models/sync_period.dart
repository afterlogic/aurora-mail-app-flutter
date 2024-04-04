import 'package:aurora_mail/generated/l10n.dart';
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
        return S.of(context).settings_sync_period_all_time;
      case Period.months1:
        return S.of(context).settings_sync_period_months1;
      case Period.months3:
        return S.of(context).settings_sync_period_months3;
      case Period.months6:
        return S.of(context).settings_sync_period_months6;
      case Period.years1:
        return S.of(context).settings_sync_period_years1;
    }
  }

  static String periodToDbString(Period period) {
    return period.toString();
  }

  static String subtractPeriodFromNow(Duration duration) {
    return DateFormat("yyyy.MM.dd").format(DateTime.now().subtract(duration));
  }

  static String? periodToDate(Period period) {
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

  static Period dbStringToPeriod(String? str) {
    if (str == null) return Period.months3;
    return Period.values.firstWhere(
      (e) => e.toString() == str,
      orElse: () => Period.months3,
    );
  }
}
