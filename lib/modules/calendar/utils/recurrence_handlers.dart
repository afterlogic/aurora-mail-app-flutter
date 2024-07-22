
import '../../../database/app_database.dart';

List<ActivityDb> handleRecurrence(DateTime intervalStartDate, DateTime intervalEndDate, List<ActivityDb> activities) {
  List<ActivityDb> generatedActivities = [];

  for (var activity in activities) {
    DateTime recurrenceEnd = activity.recurrenceUntilDate ?? intervalEndDate;
    DateTime currentStart = activity.startTS!;
    DateTime currentEnd = activity.endTS!;

    while (currentStart.isBefore(recurrenceEnd) || currentStart.isAtSameMomentAs(recurrenceEnd)) {
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