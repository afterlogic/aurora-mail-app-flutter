import 'dart:math';

import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
const int slotsNumber = 3;

void spreadWeekEvents(Week week) {

  for (var event in week.events) {
    // reset slot solution 1: event slot in different weeks is independent
    // event.slot = null;

    for (int dayIndex = 0; dayIndex < week.days.length; dayIndex++) {
      var day = week.days[dayIndex];

      // if event was marked earlier as overflow then skipping this day
      if ((event.startDate.withoutTime.isBefore(day.date) || event.startDate.withoutTime.isAtSameMomentAs(day.date)) && (event.endDate.withoutTime.isAfterOrEqual(day.date))) {
        if (event.overflow == true) {
          day.moreNumber++;
        } else {
          if (event.slotIndex != null) {
            day.events[event.slotIndex!] = event;
          } else {
            int? foundedFreeSlot;
            for (int slotIndex = 0; slotIndex < slotsNumber; slotIndex++) {
              if (day.events[slotIndex] == null) {
                bool isSloIsFree = true;
                for (int i = dayIndex;
                    i < min(week.days.length, dayIndex + event.duration.inDays);
                    i++) {
                  if (week.days[i].events[slotIndex] != null) {
                    // found non-empty slot
                    isSloIsFree = false;
                    break;
                  }
                }

                if (isSloIsFree) {
                  foundedFreeSlot = slotIndex;
                  break;
                }
              }
            }

            if (foundedFreeSlot != null) {
              event.slotIndex = foundedFreeSlot; // remembering the free slot number
              day.events[foundedFreeSlot] =
                  event; // saving event to the free slot
            } else {
              event.overflow = true;
              day.moreNumber++;
            }
          }
        }
      }
    }
  }
}

List<Week> processEvents(List<Week> weeks, List<ExtendedMonthEvent> eventsSource) {
  // sort events by duration
  eventsSource.sort((a, b) => b.duration.compareTo(a.duration));

  for (var week in weeks) {
    week.events = eventsSource
        .where((item) =>
            (item.startDate.isBefore(week.days.last.date) ||
                    item.startDate.isAtSameMomentAs(week.days.last.date)) &&
                (item.startDate.isAfter(week.days.first.date) ||
                    item.startDate.isAtSameMomentAs(week.days.first.date)) ||
            (item.endDate.isBefore(week.days.last.date) ||
                    item.endDate.isAtSameMomentAs(week.days.last.date)) &&
                (item.endDate.isAfter(week.days.first.date) ||
                    item.endDate.isAtSameMomentAs(week.days.first.date)))
        .toList();

    print(week.events);

    // populating days with empty events
    for (var day in week.days) {
      day.events = List.filled(slotsNumber, null);
    }

    // reset slot solution 2: event slot in different weeks remain the same
    var withSlot = week.events.where((item) => item.slotIndex != null).toList();
    var withoutSlot = week.events.where((item) => item.slotIndex == null).toList();
    week.events = [...withSlot, ...withoutSlot];

    spreadWeekEvents(week);

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

List<Week> generateWeeks(DateTime startDate, DateTime endDate) {
  List<Week> weeks = [];

  DateTime currentDay = startDate;

  while (currentDay.isBefore(endDate) || currentDay.isAtSameMomentAs(endDate)) {
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
        resultMap[DateTime(day.date.year, day.date.month, day.date.day)] = day.events;
      }
    }
  }
  return resultMap;
}


class Week {
  List<ExtendedMonthEvent> events;
  List<Day> days;
  Week({required this.events, required this.days });
}

class Day {
  DateTime date;
  List<ExtendedMonthEvent?> events;
  int moreNumber;
  Day({required this.events, required this.date, this.moreNumber = 0});

}