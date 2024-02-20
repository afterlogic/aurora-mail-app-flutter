//@dart=2.9
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/cupertino.dart';

enum Freq {
  never,
  minute,
  minutes5,
  minutes30,
  hours1,
  hours2,
  daily,
  monthly,
}

// Freq == frequency
class SyncFreq {
  static const NEVER_IN_SECONDS = Duration.secondsPerDay * 365 * 1000;

  static String freqToString(BuildContext context, Freq freq) {
    switch (freq) {
      case Freq.never:
        return i18n(context, S.settings_sync_frequency_never);
      case Freq.minutes5:
        return i18n(context, S.settings_sync_frequency_minutes5);
      case Freq.minutes30:
        return i18n(context, S.settings_sync_frequency_minutes30);
      case Freq.hours1:
        return i18n(context, S.settings_sync_frequency_hours1);
      case Freq.hours2:
        return i18n(context, S.settings_sync_frequency_hours2);
      case Freq.daily:
        return i18n(context, S.settings_sync_frequency_daily);
      case Freq.monthly:
        return i18n(context, S.settings_sync_frequency_monthly);
      case Freq.minute:
        return "1 minute";
      default:
        return null;
    }
  }

  static Duration freqToDuration(Freq freq) {
    switch (freq) {
      case Freq.never:
        return Duration(seconds: NEVER_IN_SECONDS);
      case Freq.minutes5:
        return Duration(minutes: 5);
      case Freq.minutes30:
        return Duration(minutes: 30);
      case Freq.hours1:
        return Duration(hours: 1);
      case Freq.hours2:
        return Duration(hours: 2);
      case Freq.daily:
        return Duration(days: 1);
      case Freq.monthly:
        return Duration(days: 30);
      case Freq.minute:
        return Duration(minutes: 1);
      default:
        return null;
    }
  }

  static Freq secondsToFreq(int seconds) {
    switch (seconds) {
      case NEVER_IN_SECONDS:
        return Freq.never;
      case Duration.secondsPerMinute * 5:
        return Freq.minutes5;
      case Duration.secondsPerMinute * 30:
        return Freq.minutes30;
      case Duration.secondsPerHour:
        return Freq.hours1;
      case Duration.secondsPerHour * 2:
        return Freq.hours2;
      case Duration.secondsPerDay:
        return Freq.daily;
      case Duration.secondsPerDay * 30:
        return Freq.monthly;
      case Duration.secondsPerMinute:
        return Freq.minute;
      default:
        throw "Provided seconds value ($seconds) is not equal to either of the current Freq options";
    }
  }
}
