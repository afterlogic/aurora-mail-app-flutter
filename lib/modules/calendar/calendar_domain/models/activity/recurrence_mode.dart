import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

enum RecurrenceMode { never, daily, weekly, monthly, yearly }

extension RecurrenceModeX on RecurrenceMode {
  static RecurrenceMode fromPeriodCode(int code) {
    switch (code) {
      case 0:
        return RecurrenceMode.never;
      case 1:
        return RecurrenceMode.daily;
      case 2:
        return RecurrenceMode.weekly;
      case 3:
        return RecurrenceMode.monthly;
      case 4:
        return RecurrenceMode.yearly;
      default:
        throw Exception('Unknown period code: $code');
    }
  }

  int get periodCode {
    switch (this) {
      case RecurrenceMode.never:
        return 0;
      case RecurrenceMode.daily:
        return 1;
      case RecurrenceMode.weekly:
        return 2;
      case RecurrenceMode.monthly:
        return 3;
      case RecurrenceMode.yearly:
        return 4;
    }
  }

  bool get isUntilOptionAvailable {
    switch (this) {
      case RecurrenceMode.daily:
      case RecurrenceMode.weekly:
        return true;
      case RecurrenceMode.monthly:
      case RecurrenceMode.yearly:
      case RecurrenceMode.never:
        return false;
    }
  }

  String buildString(BuildContext context) {
    switch (this) {
      case RecurrenceMode.never:
        return S.of(context).settings_sync_frequency_never.toCapitalize();
      case RecurrenceMode.daily:
        return S.of(context).settings_sync_frequency_daily.toCapitalize();
      case RecurrenceMode.weekly:
        return S.of(context).settings_sync_frequency_weekly.toCapitalize();
      case RecurrenceMode.monthly:
        return S.of(context).settings_sync_frequency_monthly.toCapitalize();
      case RecurrenceMode.yearly:
        return S.of(context).settings_sync_frequency_yearly.toCapitalize();
    }
  }
}
