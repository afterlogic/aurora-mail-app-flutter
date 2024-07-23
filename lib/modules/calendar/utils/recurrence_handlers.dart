import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/days_of_week.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';

List<Activity> handleRecurrence(DateTime intervalStartDate,
    DateTime intervalEndDate, List<Activity> activities) {
  final handleYear = _handleYearRecurrence(
      intervalStartDate,
      intervalEndDate,
      activities
          .where((e) => e.recurrenceMode == RecurrenceMode.yearly)
          .toList());

  final handleMonth = _handleMonthRecurrence(
      intervalStartDate,
      intervalEndDate,
      activities
          .where((e) => e.recurrenceMode == RecurrenceMode.monthly)
          .toList());

  final handledWeek = _handleWeekRecurrence(
      intervalStartDate,
      intervalEndDate,
      activities
          .where((e) => e.recurrenceMode == RecurrenceMode.weekly)
          .toList());
  final handledDay = _handleDayRecurrence(
      intervalStartDate,
      intervalEndDate,
      activities
          .where((e) => e.recurrenceMode == RecurrenceMode.daily)
          .toList());
  final result = [...handleYear, ...handleMonth, ...handledWeek, ...handledDay];
  return result;
}

List<Activity> _handleDayRecurrence(DateTime intervalStartDate,
    DateTime intervalEndDate, List<Activity> activities) {
  List<Activity> generatedActivities = [];

  for (var activity in activities) {
    DateTime recurrenceEnd = activity.recurrenceUntilDate ?? intervalEndDate;
    DateTime currentStart = activity.startTS!;
    DateTime currentEnd = activity.endTS!;

    while (currentStart.isBefore(recurrenceEnd) ||
        currentStart.isAtSameMomentAs(recurrenceEnd)) {
      if (currentStart.isAfter(intervalEndDate)) {
        break;
      }

      generatedActivities.add(
        activity.copyWith(
          startTS: currentStart,
          endTS: currentEnd,
        ),
      );

      currentStart = currentStart.add(Duration(days: 1));
      currentEnd = currentEnd.add(Duration(days: 1));
    }
  }

  return generatedActivities;
}

List<Activity> _handleWeekRecurrence(DateTime intervalStartDate,
    DateTime intervalEndDate, List<Activity> activities) {
  List<Activity> generatedActivities = [];

  for (var activity in activities) {
    generatedActivities.add(activity);

    DateTime currentEndDate = activity.recurrenceUntilDate ?? intervalEndDate;
    int weekFrequency = activity.recurrenceWeeklyFrequency!.index + 1;

    DateTime currentStartDate = activity.startTS!;

    while (currentStartDate.isBefore(currentEndDate) ||
        currentStartDate.isAtSameMomentAs(currentEndDate)) {
      if (activity.recurrenceWeekDays!
          .contains(weekDayMap[currentStartDate.weekday])) {
        DateTime newStartTS = DateTime.utc(
            currentStartDate.year,
            currentStartDate.month,
            currentStartDate.day,
            activity.startTS!.hour,
            activity.startTS!.minute);
        DateTime newEndTS =
            newStartTS.add(activity.endTS!.difference(activity.startTS!));

        if (newStartTS != activity.startTS) {
          generatedActivities
              .add(activity.copyWith(startTS: newStartTS, endTS: newEndTS));
        }
      }
      currentStartDate = currentStartDate.add(Duration(days: 1));

      if (currentStartDate.weekday == DateTime.sunday) {
        int weeksPassed =
            currentStartDate.difference(activity.startTS!).inDays ~/ 7;
        if ((weeksPassed + 1) % weekFrequency != 0) {
          currentStartDate =
              currentStartDate.add(Duration(days: 7 * (weekFrequency - 1)));
        }
      }
    }
  }

  return generatedActivities;
}

List<Activity> _handleMonthRecurrence(DateTime intervalStartDate,
    DateTime intervalEndDate, List<Activity> activities) {
  final List<Activity> generatedActivities = [];

  for (var activity in activities) {
    generatedActivities.add(activity);

    DateTime currentEndDate = activity.recurrenceUntilDate ?? intervalEndDate;
    DateTime currentStartDate =  activity.startTS!.isAfter(intervalStartDate) ? activity.startTS! : intervalStartDate;

    while (currentStartDate.isBefore(currentEndDate) ||
        currentStartDate.isAtSameMomentAs(currentEndDate)) {
      int lastDayOfMonth =
          DateTime(currentStartDate.year, currentStartDate.month + 1, 0).day;
      if (activity.startTS!.day <= lastDayOfMonth) {
        DateTime newStartTS = activity.startTS!.copyWith(
          year: currentStartDate.year,
          month: currentStartDate.month,
        );
        DateTime newEndTS =
            newStartTS.add(activity.endTS!.difference(activity.startTS!));

        print(newStartTS);
        print(activity.startTS);
        print(newStartTS != activity.startTS!);

        if (newStartTS != activity.startTS!) {
          generatedActivities
              .add(activity.copyWith(startTS: newStartTS, endTS: newEndTS));
        }
      }

      currentStartDate = DateTime(currentStartDate.year,
          currentStartDate.month + 1, currentStartDate.day);
    }
  }

  return generatedActivities;
}

List<Activity> _handleYearRecurrence(DateTime intervalStartDate,
    DateTime intervalEndDate, List<Activity> activities) {
  List<Activity> generatedActivities = [];

  for (var activity in activities) {
    generatedActivities.add(activity);

    DateTime currentEndDate = activity.recurrenceUntilDate ?? intervalEndDate;
    DateTime currentStartDate = activity.startTS!;

    while (currentStartDate.isBefore(currentEndDate) ||
        currentStartDate.isAtSameMomentAs(currentEndDate)) {
      bool isLeapYear = (currentStartDate.year % 4 == 0 &&
              currentStartDate.year % 100 != 0) ||
          (currentStartDate.year % 400 == 0);
      bool isValidDate = !(activity.startTS!.month == 2 &&
          activity.startTS!.day == 29 &&
          !isLeapYear);

      if (isValidDate) {
        DateTime newStartTS = DateTime.utc(
            currentStartDate.year,
            activity.startTS!.month,
            activity.startTS!.day,
            activity.startTS!.hour,
            activity.startTS!.minute);
        DateTime newEndTS =
            newStartTS.add(activity.endTS!.difference(activity.startTS!));

        if (newStartTS != activity.startTS) {
          generatedActivities
              .add(activity.copyWith(startTS: newStartTS, endTS: newEndTS));
        }
      }

      currentStartDate = DateTime(currentStartDate.year + 1,
          currentStartDate.month, currentStartDate.day);
    }
  }

  return generatedActivities;
}

Map<int, DaysOfWeek> weekDayMap = {
  DateTime.sunday: DaysOfWeek.su,
  DateTime.monday: DaysOfWeek.mo,
  DateTime.tuesday: DaysOfWeek.tu,
  DateTime.wednesday: DaysOfWeek.we,
  DateTime.thursday: DaysOfWeek.th,
  DateTime.friday: DaysOfWeek.fr,
  DateTime.saturday: DaysOfWeek.sa,
};
