//@dart=2.9

import 'package:aurora_mail/generated/l10n.dart';
import 'package:flutter/material.dart';

enum LifeTime {
  Day,
  Days3,
  Days7,
}

extension LifeTimeMap on LifeTime {
  String toText(BuildContext context) {
    switch (this) {
      case LifeTime.Day:
        return S.of(context).self_destructing_life_time_day;
      case LifeTime.Days3:
        return S.of(context).self_destructing_life_time_days_3;
      case LifeTime.Days7:
        return S.of(context).self_destructing_life_time_days_7;
    }
    return null;
  }

  int toHours() {
    switch (this) {
      case LifeTime.Day:
        return 24;
      case LifeTime.Days3:
        return 24 * 3;
      case LifeTime.Days7:
        return 24 * 7;
    }
    return null;
  }
}
