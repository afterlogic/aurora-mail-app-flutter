part of 'events_bloc.dart';

class EventsState extends Equatable {
  final EventsStatus status;
  final List<CalendarEvent>? events;
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;


  @override
  List<Object?> get props => [events, selectedStartDate, selectedEndDate];

  const EventsState({
    this.status = EventsStatus.idle,
    this.events,
    required this.selectedStartDate,
    required this.selectedEndDate,
  });

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' events: $events,' +
        ' selectedStartDate: $selectedStartDate,' +
        ' selectedEndDate: $selectedEndDate,' +
        '}';
  }

  EventsState copyWith({
    EventsStatus? status,
    List<CalendarEvent>? Function()? events,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
  }) {
    return EventsState(
      status: status ?? this.status,
      events: events == null ? this.events : events(),
      selectedStartDate: selectedStartDate ?? this.selectedStartDate,
      selectedEndDate: selectedEndDate ?? this.selectedEndDate,
    );
  }

}

enum EventsStatus {
  success, error, loading, idle
}

extension EventsStatusX on EventsStatus {
  bool get isSuccess => this == EventsStatus.success;
  bool get isError => this == EventsStatus.error;
  bool get isLoading => this == EventsStatus.loading;
  bool get isIdle => this == EventsStatus.idle;
}
