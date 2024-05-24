part of 'calendars_bloc.dart';

class CalendarsState extends Equatable {
  final CalendarsStatus status;
  final List<Calendar>? calendars;
  final List<String> selectedCalendarIds;

  @override
  List<Object?> get props => [status,  calendars, selectedCalendarIds];



  const CalendarsState({
    this.status = CalendarsStatus.idle,
    this.selectedCalendarIds = const [],
    this.calendars,
  });

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' calendars: $calendars,' +
        '}';
  }

  bool isCalendarSelected(Calendar calendar) =>
    selectedCalendarIds.contains(calendar.id);


  CalendarsState copyWith({
    CalendarsStatus? status,
    List<Calendar>? Function()? calendars,
    List<String>? selectedCalendarIds,
  }) {
    return CalendarsState(
      status: status ?? this.status,
      selectedCalendarIds: selectedCalendarIds ?? this.selectedCalendarIds,
      calendars: calendars == null ? this.calendars : calendars(),
    );
  }
}

enum CalendarsStatus { success, error, loading, idle }

extension CalendarsStatusX on CalendarsStatus {
  bool get isSuccess => this == CalendarsStatus.success;
  bool get isError => this == CalendarsStatus.error;
  bool get isLoading => this == CalendarsStatus.loading;
  bool get isIdle => this == CalendarsStatus.idle;
}
