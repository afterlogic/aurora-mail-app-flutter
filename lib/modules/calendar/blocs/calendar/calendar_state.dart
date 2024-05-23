part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<CalendarEvent>? events;
  final DateTime startIntervalDate;
  final DateTime endIntervalDate;
  final DateTime? selectedDate;

  @override
  List<Object?> get props => [status, events, startIntervalDate, endIntervalDate, selectedDate];
  List<CalendarEvent> get eventsByMonth {
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

  List<CalendarEvent> getEventsFromDay(DateTime date) {
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

  List<CalendarEvent>? get selectedEvents {
    if(selectedDate == null) return events;
    final filteredEvents = events?.where((e) =>
    e.startDate.isBefore(selectedDate!.startOfNextDay) &&
        e.endDate.isAfterOrEqual(selectedDate!.withoutTime)).toList();
    return filteredEvents;
  }

  const CalendarState({
    this.status = CalendarStatus.idle,
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

  CalendarState copyWith({
    CalendarStatus? status,
    List<CalendarEvent>? Function()? events,
    DateTime? startIntervalDate,
    DateTime? endIntervalDate,
    DateTime? Function()? selectedDate,
  }) {
    return CalendarState(
      status: status ?? this.status,
      events: events == null ? this.events : events(),
      startIntervalDate: startIntervalDate ?? this.startIntervalDate,
      endIntervalDate: endIntervalDate ?? this.endIntervalDate,
      selectedDate: selectedDate == null ? this.selectedDate : selectedDate()
    );
  }
}

enum CalendarStatus { success, error, loading, idle }

extension EventsStatusX on CalendarStatus {
  bool get isSuccess => this == CalendarStatus.success;
  bool get isError => this == CalendarStatus.error;
  bool get isLoading => this == CalendarStatus.loading;
  bool get isIdle => this == CalendarStatus.idle;
}
