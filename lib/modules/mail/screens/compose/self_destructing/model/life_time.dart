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
    return "";
  }
}
