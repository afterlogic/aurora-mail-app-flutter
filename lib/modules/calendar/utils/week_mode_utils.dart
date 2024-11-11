import 'package:aurora_mail/modules/calendar/ui/models/event.dart';

/**
 * This function returns a deep copy of two event collection: all day events and regular events.
 * The null events added by the Month mode are skipped.
 * TODO: Null events shouldn't be added at all in the Month mode!
 */
Map<String, Map<DateTime, List<ViewEvent?>> > deepCloneAndSeparateEvents(Map<DateTime, List<ViewEvent?>> eventsSource) {
  Map<DateTime, List<ViewEvent?>> eventsCopy = {};
  Map<DateTime, List<ViewEvent?>> allDayEventsCopy = {};

  eventsSource.forEach((key, dayEvents) {
    List<ViewEvent?> allDayEvents = [];
    List<ViewEvent?> events = [];
    dayEvents.forEach((event) {
      if (event != null) {
        if (event.allDay == true) {
          allDayEvents.add(event);
        } else {
          events.add(event);
        }
      }
    });
    eventsCopy[key] = events;
    allDayEventsCopy[key] = allDayEvents;
  });

  final result = <String, Map <DateTime, List<ViewEvent?>>>{};
  result['allDayEvents'] = allDayEventsCopy;
  result['events'] = eventsCopy;

  return result;
}

/**
 * This function adds an null values to an events collection to fill gaps in all-day mode.
 * ! Do not pass non-all-day events to the function !
 */
void normalizeAndCleanUpEvents(Map<DateTime, List<ViewEvent?>> weekEvents) {
  if (weekEvents.isEmpty) return;

  int maxEventsInDay = 0;

  for (var day in weekEvents.values) {
    if (day.length > maxEventsInDay) {
      maxEventsInDay = day.length;
    }
  }

  for (var day in weekEvents.values) {
    while (day.length < maxEventsInDay) {
      day.add(null);
    }
  }

  for (int rowIndex = maxEventsInDay - 1; rowIndex >= 0; rowIndex--) {
    bool rowIsNull = true;
    for (var day in weekEvents.values) {
      if (day.length > rowIndex && day[rowIndex] != null) {
        rowIsNull = false;
        break;
      }
    }
    if (rowIsNull) {
      for (var day in weekEvents.values) {
        if (day.length > rowIndex) {
          day.removeAt(rowIndex);
        }
      }
    }
  }
}

