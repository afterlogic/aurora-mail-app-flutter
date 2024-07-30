part of 'events_bloc.dart';

class EventsState extends Equatable {
  final EventsStatus status;
  final Map<DateTime, List<ViewEvent?>>? eventsMap;
  final List<ViewEvent>? originalEvents;
  final ViewEvent? selectedEvent;
  final DateTime startIntervalDate;
  final DateTime endIntervalDate;
  final DateTime selectedDate;
  final ErrorToShow? error;

  const EventsState({
    this.status = EventsStatus.idle,
    this.originalEvents,
    this.selectedEvent,
    this.eventsMap,
    this.error,
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
        eventsMap,
        error
      ];

  ///Events from selected date or from period between [startIntervalDate] and [endIntervalDate]
  List<ViewEvent>? get selectedEvents {
    final filteredEvents = originalEvents?.where((e) {
      final nextDay = selectedDate.startOfNextDay;
      final nextDayUtc = DateTime.utc(nextDay.year, nextDay.month, nextDay.day);
      final todayWithoutTime = selectedDate.withoutTime;
      final todayWithoutTimeUtc = DateTime.utc(
          todayWithoutTime.year, todayWithoutTime.month, todayWithoutTime.day);
      return (e.startDate.toUtc().isBefore(nextDayUtc) &&
              e.endDate.toUtc().isAfter(todayWithoutTimeUtc)) ||
          ///handle events where startDate equals endDate
          (e.startDate.toUtc().isAtSameMomentAs(e.endDate.toUtc()) &&
              (e.startDate.toUtc().isBefore(nextDayUtc) &&
                  e.endDate.toUtc().isAfterOrEqual(todayWithoutTimeUtc)));
    }).toList();
    return filteredEvents;
  }

  List<DateTime> _daysFromInterval(DateTime start, DateTime end) {
    List<DateTime> dates = [];

    if (start.isAfter(end)) {
      return dates;
    }

    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(Duration(days: 1));
    }

    return dates;
  }

  Map<DateTime, List<ViewEvent?>> getEventsFromWeek({DateTime? date}) {
    if (originalEvents == null) {
      return {};
    }

    DateTime startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    final dates = _daysFromInterval(startOfWeek, endOfWeek);
    final Map<DateTime, List<ViewEvent?>> result = {};

    for (final date in dates) {
      result.addAll({date: getEventsForDayFromMap(date: date)});
    }

    return result;

    // final selectedEvents = originalEvents!.where((event) {
    //   return !(event.endDate.isBefore(startOfWeek) ||
    //       event.startDate.isAfter(endOfWeek));
    // }).toList();
    // return selectedEvents
    //     .expand<ViewEvent>(
    //         (e) => e.allDay != false ? [e] : e.splitIntoDailyEvents)
    //     .toList();
  }

  List<ViewEvent?> getEventsForDayFromMap({required DateTime date}) {
    return eventsMap?[DateTime(date.year, date.month, date.day)] ?? [];
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
  }

  ViewEvent _expandEventTime(
      {required ViewEvent e, required DateTime currentDate}) {
    final updatedStart =
        e.isStartedToday(currentDate) ? e.startDate : e.startDate.withoutTime;
    final updatedEnd = e.isEndedToday(currentDate)
        ? e.endDate
        : e.endDate.withoutTime.add(Duration(hours: 23, minutes: 59));

    return e.copyWith(startDate: () => updatedStart, endDate: () => updatedEnd);
  }

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
    ErrorToShow? Function()? error,
    List<ViewEvent>? Function()? originalEvents,
    ViewEvent? Function()? selectedEvent,
    List<Calendar>? Function()? calendars,
    DateTime? startIntervalDate,
    DateTime? endIntervalDate,
    DateTime? selectedDate,
  }) {
    return EventsState(
      status: status ?? this.status,
      error: error == null ? this.error : error(),
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
