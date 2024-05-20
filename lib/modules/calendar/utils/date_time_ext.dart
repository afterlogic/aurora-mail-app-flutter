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

  DateTime get nextDayWithoutTime {
    DateTime nextDay = this.add(Duration(days: 1));
    return DateTime(nextDay.year, nextDay.month, nextDay.day);
  }
}
