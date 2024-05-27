part of 'events_bloc.dart';

class EventsState extends Equatable {
  final EventsStatus status;
  final List<ViewEvent>? events;
  final DateTime startIntervalDate;
  final DateTime endIntervalDate;
  final DateTime? selectedDate;

  @override
  List<Object?> get props => [status, events, startIntervalDate, endIntervalDate, selectedDate];
  List<ViewEvent> get eventsByMonth {
    if (events == null) {
      return [];
    }
    int targetYear = startIntervalDate.year;
    int targetMonth = startIntervalDate.month;

    return events!.where((event) {
      return (event.startDate.year <= targetYear &&
              event.startDate.month <= targetMonth) &&
          (event.endDate.year >= targetYear &&
              event.endDate.month >= targetMonth);
    }).toList();
  }

  List<ViewEvent> getEventsFromDay(DateTime date) {
    if (events == null) {
      return [];
    }
    int targetYear = date.year;
    int targetMonth = date.month;
    int targetDay = date.day;

    return events!.where((event) {
      return (event.startDate.year <= targetYear &&
              event.startDate.month <= targetMonth &&
              event.startDate.day <= targetDay) &&
          (event.endDate.year >= targetYear &&
              event.endDate.month >= targetMonth &&
              event.endDate.day >= targetDay);
    }).toList();
  }

  List<ViewEvent>? get selectedEvents {
    if(selectedDate == null) return events;
    final filteredEvents = events?.where((e) =>
    e.startDate.isBefore(selectedDate!.startOfNextDay) &&
        e.endDate.isAfterOrEqual(selectedDate!.withoutTime)).toList();
    return filteredEvents;
  }

  const EventsState({
    this.status = EventsStatus.idle,
    this.events,
    required this.startIntervalDate,
    required this.endIntervalDate,
    this.selectedDate,
  });

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' events: $events,' +
        ' startIntervalDate: $startIntervalDate,' +
        ' endIntervalDate: $endIntervalDate,' +
        ' selectedDate: $selectedDate,' +
        '}';
  }

  EventsState copyWith({
    EventsStatus? status,
    List<ViewEvent>? Function()? events,
    List<Calendar>? Function()? calendars,
    DateTime? startIntervalDate,
    DateTime? endIntervalDate,
    DateTime? Function()? selectedDate,
  }) {
    return EventsState(
      status: status ?? this.status,
      events: events == null ? this.events : events(),
      startIntervalDate: startIntervalDate ?? this.startIntervalDate,
      endIntervalDate: endIntervalDate ?? this.endIntervalDate,
      selectedDate: selectedDate == null ? this.selectedDate : selectedDate()
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
