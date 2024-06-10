part of 'events_bloc.dart';

class EventsState extends Equatable {
  final EventsStatus status;
  final Map<DateTime, List<ViewEvent?>>? eventsMap;
  final List<ViewEvent>? originalEvents;
  final ViewEvent? selectedEvent;
  final DateTime startIntervalDate;
  final DateTime endIntervalDate;
  final DateTime selectedDate;

  const EventsState({
    this.status = EventsStatus.idle,
    this.originalEvents,
    this.selectedEvent,
    this.eventsMap,
    required this.startIntervalDate,
    required this.endIntervalDate,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [
        status,
        originalEvents,
        selectedEvent,
        startIntervalDate,
        endIntervalDate,
        selectedDate,
        eventsMap
      ];
  // List<ViewEvent> get eventsByMonth {
  //   if (splitEvents == null) {
  //     return [];
  //   }
  //   int targetYear = startIntervalDate.year;
  //   int targetMonth = startIntervalDate.month;
  //
  //   return splitEvents!.where((event) {
  //     return (event.startDate.year <= targetYear &&
  //             event.startDate.month <= targetMonth) &&
  //         (event.endDate.year >= targetYear &&
  //             event.endDate.month >= targetMonth);
  //   }).toList();
  // }

  ///Events from selected date or from period between [startIntervalDate] and [endIntervalDate]
  List<ViewEvent>? get selectedEvents {
    final filteredEvents = originalEvents
        ?.where((e) =>
            e.startDate.isBefore(selectedDate.startOfNextDay) &&
            e.endDate.isAfterOrEqual(selectedDate.withoutTime))
        .toList();
    return filteredEvents;
  }

  List<ViewEvent> getEventsFromWeek({DateTime? date}) {
    if (originalEvents == null) {
      return [];
    }

    DateTime startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    final selectedEvents = originalEvents!.where((event) {
      return !(event.endDate.isBefore(startOfWeek) ||
          event.startDate.isAfter(endOfWeek));
    }).toList();
    return selectedEvents
        .expand<ViewEvent>(
            (e) => e.allDay != false ? [e] : e.splitIntoDailyEvents)
        .toList();
  }

  List<ViewEvent?> getEventsForDayFromMap({DateTime? date}) {
    return eventsMap?[date] ?? [];
  }

  List<ViewEvent> getEventsFromDay({DateTime? date}) {
    late int targetYear;
    late int targetMonth;
    late int targetDay;

    if (date != null) {
      targetYear = date.year;
      targetMonth = date.month;
      targetDay = date.day;
    } else {
      targetYear = selectedDate.year;
      targetMonth = selectedDate.month;
      targetDay = selectedDate.day;
    }

    final targetDate = DateTime(targetYear, targetMonth, targetDay);

    final events =
        getEventsForDayFromMap(date: targetDate).whereNotNull().toList();

    return events
        .map((e) => _expandEventTime(e: e, currentDate: targetDate))
        .toList();

    //
    // return splitEvents!.where((event) {
    //   return (event.startDate.year <= targetYear &&
    //           event.startDate.month <= targetMonth &&
    //           event.startDate.day <= targetDay) &&
    //       (event.endDate.year >= targetYear &&
    //           event.endDate.month >= targetMonth &&
    //           event.endDate.day >= targetDay);
    // }).toList();
  }

  ViewEvent _expandEventTime(
      {required ViewEvent e, required DateTime currentDate}) {
    final updatedStart =
        e.isStartedToday(currentDate) ? e.startDate : e.startDate.withoutTime;
    final updatedEnd = e.isEndedToday(currentDate)
        ? e.endDate
        : e.endDate.withoutTime.add(Duration(hours: 23, minutes: 59));

    return e.copyWith(startDate: updatedStart, endDate: updatedEnd);
  }

  // Map<DateTime, List<ViewEvent>> groupSelectedEventsByDay() {
  //   final Map<DateTime, List<ViewEvent>> eventMap = {};
  //   if (splitEvents == null) return eventMap;
  //
  //   for (final event in splitEvents!) {
  //     DateTime current = event.startDate;
  //
  //     while (current.isBefore(event.endDate) ||
  //         current.isAtSameMomentAs(event.endDate)) {
  //       // date without time
  //       DateTime dayKey = DateTime(current.year, current.month, current.day);
  //
  //       if (eventMap.containsKey(dayKey)) {
  //         eventMap[dayKey]!.add(event);
  //       } else {
  //         eventMap[dayKey] = [event];
  //       }
  //       current = current.add(Duration(days: 1));
  //     }
  //   }
  //
  //   return eventMap;
  // }

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' originalEvents: $originalEvents,' +
        ' startIntervalDate: $startIntervalDate,' +
        ' endIntervalDate: $endIntervalDate,' +
        ' selectedDate: $selectedDate,' +
        '}';
  }

  EventsState copyWith({
    EventsStatus? status,
    Map<DateTime, List<ViewEvent?>>? Function()? eventsMap,
    List<ViewEvent>? Function()? originalEvents,
    ViewEvent? Function()? selectedEvent,
    List<Calendar>? Function()? calendars,
    DateTime? startIntervalDate,
    DateTime? endIntervalDate,
    DateTime? selectedDate,
  }) {
    return EventsState(
      status: status ?? this.status,
      eventsMap: eventsMap == null ? this.eventsMap : eventsMap(),
      originalEvents:
          originalEvents == null ? this.originalEvents : originalEvents(),
      selectedEvent:
          selectedEvent == null ? this.selectedEvent : selectedEvent(),
      startIntervalDate: startIntervalDate ?? this.startIntervalDate,
      endIntervalDate: endIntervalDate ?? this.endIntervalDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

enum EventsStatus { success, error, loading, idle }

extension EventsStatusX on EventsStatus {
  bool get isSuccess => this == EventsStatus.success;
  bool get isError => this == EventsStatus.error;
  bool get isLoading => this == EventsStatus.loading;
  bool get isIdle => this == EventsStatus.idle;
}
