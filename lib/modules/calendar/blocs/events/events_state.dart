part of 'events_bloc.dart';

class EventsState extends Equatable {
  final EventsStatus status;
  final Map<DateTime, List<ViewEvent?>>? eventsMap;
  final List<ViewEvent>? splitEvents;
  final List<ViewEvent>? originalEvents;
  final DateTime startIntervalDate;
  final DateTime endIntervalDate;
  final DateTime? selectedDate;

  const EventsState({
    this.status = EventsStatus.idle,
    this.splitEvents,
    this.originalEvents,
    this.eventsMap,
    required this.startIntervalDate,
    required this.endIntervalDate,
    this.selectedDate,
  });

  @override
  List<Object?> get props => [
        status,
        splitEvents,
        originalEvents,
        startIntervalDate,
        endIntervalDate,
        selectedDate,
    eventsMap
      ];
  List<ViewEvent> get eventsByMonth {
    if (splitEvents == null) {
      return [];
    }
    int targetYear = startIntervalDate.year;
    int targetMonth = startIntervalDate.month;

    return splitEvents!.where((event) {
      return (event.startDate.year <= targetYear &&
              event.startDate.month <= targetMonth) &&
          (event.endDate.year >= targetYear &&
              event.endDate.month >= targetMonth);
    }).toList();
  }

  ///Events from selected date or from period between [startIntervalDate] and [endIntervalDate]
  List<ViewEvent>? get selectedEvents {
    if (selectedDate == null) return splitEvents;
    final filteredEvents = splitEvents
        ?.where((e) =>
            e.startDate.isBefore(selectedDate!.startOfNextDay) &&
            e.endDate.isAfterOrEqual(selectedDate!.withoutTime))
        .toList();
    return filteredEvents;
  }

  List<ViewEvent> getEventsFromWeek({DateTime? date}) {
    if (splitEvents == null) {
      return [];
    }

    DateTime targetDate = date ?? (selectedDate ?? startIntervalDate);

    DateTime startOfWeek = targetDate.subtract(Duration(days: targetDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    return splitEvents!.where((event) {
      return !(event.endDate.isBefore(startOfWeek) || event.startDate.isAfter(endOfWeek));
    }).toList();
  }

  List<ViewEvent?> getEventsForDayFromMap({DateTime? date}) {
    return eventsMap?[date] ?? [];
  }

  List<ViewEvent> getEventsFromDay({DateTime? date}) {
    if (splitEvents == null) {
      return [];
    }
    late int targetYear;
    late int targetMonth;
    late int targetDay;

    if (date != null) {
      targetYear = date.year;
      targetMonth = date.month;
      targetDay = date.day;
    } else {
      targetYear = selectedDate == null ? startIntervalDate.year : selectedDate!.year;
      targetMonth = selectedDate == null ? startIntervalDate.month : selectedDate!.month;
      targetDay = selectedDate == null ? startIntervalDate.day : selectedDate!.day;
    }

    return splitEvents!.where((event) {
      return (event.startDate.year <= targetYear &&
              event.startDate.month <= targetMonth &&
              event.startDate.day <= targetDay) &&
          (event.endDate.year >= targetYear &&
              event.endDate.month >= targetMonth &&
              event.endDate.day >= targetDay);
    }).toList();
  }

  Map<DateTime, List<ViewEvent>> groupSelectedEventsByDay() {
    final Map<DateTime, List<ViewEvent>> eventMap = {};
    if (splitEvents == null) return eventMap;

    for (final event in splitEvents!) {
      DateTime current = event.startDate;

      while (current.isBefore(event.endDate) ||
          current.isAtSameMomentAs(event.endDate)) {
        // date without time
        DateTime dayKey = DateTime(current.year, current.month, current.day);

        if (eventMap.containsKey(dayKey)) {
          eventMap[dayKey]!.add(event);
        } else {
          eventMap[dayKey] = [event];
        }
        current = current.add(Duration(days: 1));
      }
    }

    return eventMap;
  }

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' splitEvents: $splitEvents,' +
        ' originalEvents: $originalEvents,' +
        ' startIntervalDate: $startIntervalDate,' +
        ' endIntervalDate: $endIntervalDate,' +
        ' selectedDate: $selectedDate,' +
        '}';
  }

  EventsState copyWith({
    EventsStatus? status,
    List<ViewEvent>? Function()? splitEvents,
    Map<DateTime, List<ViewEvent?>>? Function()? eventsMap,
    List<ViewEvent>? Function()? originalEvents,
    List<Calendar>? Function()? calendars,
    DateTime? startIntervalDate,
    DateTime? endIntervalDate,
    DateTime? Function()? selectedDate,
  }) {
    return EventsState(
        status: status ?? this.status,
        splitEvents: splitEvents == null ? this.splitEvents : splitEvents(),
        eventsMap: eventsMap == null ? this.eventsMap : eventsMap(),
        originalEvents:
            originalEvents == null ? this.originalEvents : originalEvents(),
        startIntervalDate: startIntervalDate ?? this.startIntervalDate,
        endIntervalDate: endIntervalDate ?? this.endIntervalDate,
        selectedDate:
            selectedDate == null ? this.selectedDate : selectedDate());
  }
}

enum EventsStatus { success, error, loading, idle }

extension EventsStatusX on EventsStatus {
  bool get isSuccess => this == EventsStatus.success;
  bool get isError => this == EventsStatus.error;
  bool get isLoading => this == EventsStatus.loading;
  bool get isIdle => this == EventsStatus.idle;
}
