enum Freq {
  never,
  minutes1,
  minutes5,
  hours1,
  hours2,
  daily,
  monthly,
}

// Freq == frequency
class SyncFreq {
  static const _NEVER_IN_SECONDS = Duration.secondsPerDay * 365 * 1000;

  static String freqToString(Freq freq) {
    switch (freq) {
      // TODO translate
      case Freq.never:
        return "never";
      case Freq.minutes1:
        return "1 minute";
      case Freq.minutes5:
        return "5 minutes";
      case Freq.hours1:
        return "1 hour";
      case Freq.hours2:
        return "2 hours";
      case Freq.daily:
        return "daily";
      case Freq.monthly:
        return "monthly";
      default:
        return null;
    }
  }

  static Duration freqToDuration(Freq freq) {
    switch (freq) {
      case Freq.never:
        return Duration(seconds: _NEVER_IN_SECONDS);
      case Freq.minutes1:
        return Duration(minutes: 1);
      case Freq.minutes5:
        return Duration(minutes: 5);
      case Freq.hours1:
        return Duration(hours: 1);
      case Freq.hours2:
        return Duration(hours: 2);
      case Freq.daily:
        return Duration(days: 1);
      case Freq.monthly:
        return Duration(days: 30);
      default:
        return null;
    }
  }

  static Freq secondsToFreq(int seconds) {
    switch (seconds) {
      case _NEVER_IN_SECONDS:
        return Freq.never;
      case Duration.secondsPerMinute:
        return Freq.minutes1;
      case Duration.secondsPerMinute * 5:
        return Freq.minutes5;
      case Duration.secondsPerHour:
        return Freq.hours1;
      case Duration.secondsPerHour * 2:
        return Freq.hours2;
      case Duration.secondsPerDay:
        return Freq.daily;
      case Duration.secondsPerDay * 30:
        return Freq.monthly;
      default:
        throw "Provided seconds value ($seconds) is not equal to either of the current Freq options";
    }
  }
}
