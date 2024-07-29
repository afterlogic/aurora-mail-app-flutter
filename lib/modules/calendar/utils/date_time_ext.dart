extension DateTimeExtension on DateTime {
  DateTime get lastDayOfMonth {
    final int nextMonth = month == 12 ? 1 : month + 1;
    final int nextMonthYear = month == 12 ? year + 1 : year;

    final DateTime firstDayOfNextMonth = DateTime(nextMonthYear, nextMonth, 1);

    return firstDayOfNextMonth.subtract(Duration(days: 1));
  }

  DateTime get firstDayOfMonth {
    return DateTime(year, month);
  }

  // DateTime get withoutTime => DateTime(year, month, day);

  DateTime get firstDayOfPreviousMonth {
    int previousMonth = month - 1;
    int previousYear = year;

    if (previousMonth == 0) {
      previousMonth = 12;
      previousYear--;
    }
    return DateTime(previousYear, previousMonth, 1);
  }

  DateTime get firstDayOfNextMonth {
    int nextMonth = month + 1;
    int nextYear = year;

    if (nextMonth == 13) {
      nextMonth = 1;
      nextYear++;
    }
    return DateTime(nextYear, nextMonth, 1);
  }

  DateTime get startOfNextDay {
    DateTime nextDay = this.add(Duration(days: 1));
    return DateTime(nextDay.year, nextDay.month, nextDay.day);
  }

  bool isAtSameDay(DateTime other) {
    final utcCurrent = DateTime.utc(this.year, this.month, this.day);
    final utcOther = DateTime.utc(other.year, other.month, other.day);
    
    return utcCurrent.isAtSameMomentAs(utcOther);
  }

  bool isAfterOrEqual(DateTime other) {
    return this.isAfter(other) || this.isAtSameMomentAs(other);
  }

  bool isBeforeOrEqual(DateTime other) {
    return this.isBefore(other) || this.isAtSameMomentAs(other);
  }
}
