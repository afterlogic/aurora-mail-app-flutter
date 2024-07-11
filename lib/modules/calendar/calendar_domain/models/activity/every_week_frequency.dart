enum EveryWeekFrequency {
  every1,
  every2,
  every3,
  every4,
}

extension EveryWeekFrequencyX on EveryWeekFrequency {
  static EveryWeekFrequency fromIntervalCode(int code) {
    switch (code) {
      case 1:
        return EveryWeekFrequency.every1;
      case 2:
        return EveryWeekFrequency.every2;
      case 3:
        return EveryWeekFrequency.every3;
      case 4:
        return EveryWeekFrequency.every4;
      default:
        throw Exception('Unknown interval code: $code');
    }
  }

  int get intervalCode {
    switch (this) {
      case EveryWeekFrequency.every1:
        return 1;
      case EveryWeekFrequency.every2:
        return 2;
      case EveryWeekFrequency.every3:
        return 3;
      case EveryWeekFrequency.every4:
        return 4;
    }
  }

  String buildString() {
    switch (this) {
      case EveryWeekFrequency.every1:
        return '1';
      case EveryWeekFrequency.every2:
        return '2';
      case EveryWeekFrequency.every3:
        return '3';
      case EveryWeekFrequency.every4:
        return '4';
    }
  }
}
