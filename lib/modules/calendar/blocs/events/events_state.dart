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
  ///where 1 - monday, 7 - sunday
  final int firstDayInWeek;

  const EventsState({
    this.status = EventsStatus.idle,
    this.originalEvents,
    this.selectedEvent,
    this.eventsMap,
    this.error,
    required this.firstDayInWeek,
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
        error,
        firstDayInWeek
      ];

  ///Events from selected date or from period between [startIntervalDate] and [endIntervalDate]
  List<ViewEvent>? get selectedEvents {
    final filteredEvents = originalEvents?.where((event) {
      final tomorrowStart = selectedDate.startOfNextDay.toUtc();
      final todayStart = selectedDate.withoutTime.toUtc();
      final todayLocal = selectedDate.withoutTime.toLocal();

      // final title = event.title;
      final isAllDay = event.allDay == true;
      final eventStart = isAllDay
          ? DateTime(event.startDate.year, event.startDate.month, event.startDate.day)
          : event.startDate.toUtc();
      final eventEnd = isAllDay
          ? DateTime(event.endDate.year, event.endDate.month, event.endDate.day)
          : event.endDate.toUtc();

      /// Compare all day events which has no time (shouldn't have, actually the time is 00:00:00)
      final compareAllDayEvents = isAllDay
          && eventStart.isBefore(tomorrowStart)
          && eventEnd.isAfter(todayStart)
          && !eventEnd.isAtSameMomentAs(todayLocal); /// all-day event ends at 00:00:00 of the next day

      /// Compare events that has date and time
      final compareRegularEvents = !isAllDay
          && eventStart.isBefore(tomorrowStart)
          && eventEnd.isAfter(todayStart);

      /// handle events where startDate equals endDate
      final compareRegularEventsAlt = !isAllDay
          && eventStart.isAtSameMomentAs(eventEnd)
          && eventStart.isBefore(tomorrowStart)
          && eventEnd.isAfterOrEqual(todayStart);

      return compareAllDayEvents || compareRegularEvents || compareRegularEventsAlt;
    }).toList();
    return filteredEvents;
  }

  List<DateTime> _datesFromInterval(DateTime start, DateTime end) {
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

  DateTime _getStartOfWeek(DateTime currentDate, int startDay) {
    // monday - 1
    // sunday - 7
    int normalizedStartDay = (startDay - 1) % 7;

    int currentDayOfWeek = (currentDate.weekday - 1) % 7;

    int daysToSubtract = (currentDayOfWeek - normalizedStartDay) % 7;

    if (daysToSubtract < 0) {
      daysToSubtract += 7;
    }

    return currentDate.subtract(Duration(days: daysToSubtract));
  }

  Map<DateTime, List<ViewEvent?>> getEventsForWeek({DateTime? date}) {
    if (originalEvents == null) {
      return {};
    }

    final DateTime startOfWeek = _getStartOfWeek(selectedDate, firstDayInWeek);
    final DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    final dates = _datesFromInterval(startOfWeek, endOfWeek);
    final Map<DateTime, List<ViewEvent?>> result = {};

    for (final date in dates) {
      result.addAll({date: getEventsForDayFromMap(date: date)});
    }

    return result;
  }

  List<ViewEvent?> getEventsForDayFromMap({required DateTime date}) {
    return eventsMap?[DateTime(date.year, date.month, date.day)] ?? [];
  }

  List<ViewEvent> getEventsForDay({DateTime? date}) {
    final events = date == null
        /// Getting events for the selected date
        ? (selectedEvents ?? [])
        /// This case is actually isn't used, kept it just for backward compatibility,
        : getEventsForDayFromMap(date: DateTime(date.year, date.month, date.day))
          .whereNotNull()
          .toList();

    return events
        .map((event) => _expandEventTime(event: event, currentDate: selectedDate))
        .toList();
  }

  ViewEvent _expandEventTime({
    required ViewEvent event,
    required DateTime currentDate
  }) {
    final updatedStart = event.isStartedToday(currentDate)
        ? event.startDate
        : event.startDate.withoutTime;

    final updatedEnd = event.isEndedToday(currentDate)
        ? event.endDate
        : event.endDate.withoutTime.add(Duration(hours: 23, minutes: 59));

    return event.copyWith(startDate: () => updatedStart, endDate: () => updatedEnd);
  }

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' originalEventsLength: ${originalEvents?.length},' +
        ' eventsMapLength: ${eventsMap?.length},' +
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
    int? firstDayInWeek
  }) {
    return EventsState(
      status: status ?? this.status,
      error: error == null ? this.error : error(),
      eventsMap: eventsMap == null ? this.eventsMap : eventsMap(),
      originalEvents: originalEvents == null ? this.originalEvents : originalEvents(),
      selectedEvent: selectedEvent == null ? this.selectedEvent : selectedEvent(),
      startIntervalDate: startIntervalDate ?? this.startIntervalDate,
      endIntervalDate: endIntervalDate ?? this.endIntervalDate,
      selectedDate: selectedDate ?? this.selectedDate,
      firstDayInWeek: firstDayInWeek ?? this.firstDayInWeek,
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
