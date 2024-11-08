import 'dart:math';

import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:calendar_view/calendar_view.dart';

const int slotsNumber = 3;

List<T?> _ensureCapacity<T>(int index, List<T?> events) {
  if (index > events.length - 1) {
    while (events.length <= index) {
      events.add(null);
    }
  }
  return events;
}

void spreadWeekEvents(Week week) {
  for (var event in week.events) {
    for (int dayIndex = 0; dayIndex < week.days.length; dayIndex++) {
      final day = week.days[dayIndex];
      final eventStartDate = event.startDate.withoutTime;

      /// If end date equals 00:00:00 this means that it ands at 24:00 of the previous day.
      /// So, it's necessary to correct the end date
      final eventEndDate = event.endDate.isAtSameMomentAs(day.date)
        ? event.endDate.subtract(Duration(seconds: 1)).withoutTime
        : event.endDate.withoutTime;

      final startsBefore = eventStartDate.isBeforeOrEqual(day.date);
      final endsAfter = eventEndDate.isAfterOrEqual(day.date);

      if (startsBefore && endsAfter) {
        if (event.slotIndex != null) {
          day.events = _ensureCapacity(event.slotIndex!, day.events);
          day.events[event.slotIndex!] = event;
        } else {
          int? foundedFreeSlot;
          for (int slotIndex = 0;; slotIndex++) {
            if (slotIndex > day.events.length - 1) {
              day.events.add(null);
            }
            bool isSloIsFree = true;
            for (int i = dayIndex; i < week.days.length; i++) {
              week.days[i].events =
                  _ensureCapacity(slotIndex, week.days[i].events);
              if (week.days[i].events[slotIndex] != null) {
                isSloIsFree = false;
                break;
              }
            }
            if (isSloIsFree) {
              foundedFreeSlot = slotIndex;
              break;
            }
          }

          event.slotIndex = foundedFreeSlot; // remembering the free slot number
          day.events[foundedFreeSlot] = event; // saving event to the free slot
        }
      }
    }
  }
}

List<Week> processEvents(
    List<Week> weeks, List<ExtendedMonthEvent> eventsSource) {
  // sort events by duration
  eventsSource.sort((a, b) => b.duration.compareTo(a.duration));

  for (var week in weeks) {
    week.events = eventsSource.where((item) {
      final result = (item.startDate.withoutTime
                  .isBeforeOrEqual(week.days.last.date.withoutTime) &&
              item.startDate
                  .isAfterOrEqual(week.days.first.date.withoutTime)) ||
          (item.endDate.isBeforeOrEqual(week.days.last.date.withoutTime) &&
              item.endDate.isAfterOrEqual(week.days.first.date.withoutTime));
      return result;
    }).toList();

    // populating days with empty events
    for (var day in week.days) {
      day.events = [];
    }

    // reset slot solution 2: event slot in different weeks remain the same
    var withSlot = week.events.where((item) => item.slotIndex != null).toList();
    var withoutSlot =
        week.events.where((item) => item.slotIndex == null).toList();
    week.events = [...withSlot, ...withoutSlot];

    spreadWeekEvents(week);
    _normalizeEventsLength(week);
    // removing unnecessary empty events
    // for (var day in week.days) {
    //   int maxIndexPerDay = -1;
    //   for (int index = 0; index < day.events.length; index++) {
    //     if (day.events[index] != null && index > maxIndexPerDay) {
    //       maxIndexPerDay = index;
    //     }
    //   }
    //   day.events.removeRange(maxIndexPerDay + 1, day.events.length);
    // }
  }

  return weeks;
}

void _normalizeEventsLength(Week week) {
  int maxLength = 0;
  for (var day in week.days) {
    if (day.events.length > maxLength) {
      maxLength = day.events.length;
    }
  }

  for (var day in week.days) {
    while (day.events.length < maxLength) {
      day.events.add(null);
    }
  }
}

List<Week> generateWeeks(DateTime startDate, DateTime endDate) {
  List<Week> weeks = [];

  DateTime currentDay = startDate;

  while (currentDay.isBeforeOrEqual(endDate)) {
    List<Day> days = [];

    for (int i = 0; i < 7; i++) {
      Day day = Day(date: currentDay, events: []);
      days.add(day);
      currentDay = currentDay.add(Duration(days: 1));
    }

    Week week = Week(events: [], days: days);
    weeks.add(week);
  }

  return weeks;
}

Map<DateTime, List<ExtendedMonthEvent?>> convertWeeksToMap(List<Week> weeks) {
  Map<DateTime, List<ExtendedMonthEvent?>> resultMap = {};

  for (final Week week in weeks) {
    for (final Day day in week.days) {
      if (!resultMap.containsKey(day.date)) {
        resultMap[DateTime(day.date.year, day.date.month, day.date.day)] =
            day.events;
      }
    }
  }
  return resultMap;
}

class Week {
  List<ExtendedMonthEvent> events;
  List<Day> days;
  Week({required this.events, required this.days});
}

class Day {
  DateTime date;
  List<ExtendedMonthEvent?> events;
  int moreNumber;
  Day({required this.events, required this.date, this.moreNumber = 0});
}
