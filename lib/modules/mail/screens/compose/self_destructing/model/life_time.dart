enum LifeTime {
  Day,
  Days3,
  Days7,
}

extension LifeTimeMap on LifeTime {
  String toText() {
    switch (this) {
      case LifeTime.Day:
        return "life_time_day";
      case LifeTime.Days3:
        return "life_time_days_3";
      case LifeTime.Days7:
        return "life_time_days_7";
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
