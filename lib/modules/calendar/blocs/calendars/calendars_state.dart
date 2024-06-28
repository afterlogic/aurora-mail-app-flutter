part of 'calendars_bloc.dart';

class CalendarsState extends Equatable {
  final CalendarsStatus status;
  final List<ViewCalendar>? calendars;
  final int? selectedTabIndex;
  final MonthViewMode? monthViewMode;

  @override
  List<Object?> get props =>
      [status, calendars, selectedTabIndex, monthViewMode];

  List<ViewCalendar> get availableCalendars => calendars == null
      ? <ViewCalendar>[]
      : calendars!
          .where((e) =>
              (!e.shared &&
              !e.sharedToAll )||
              (e.shared && e.access == 1 && !e.sharedToAll) ||
              (e.sharedToAll && e.sharedToAllAccess == 1 ))
          .toList();

  const CalendarsState({
    this.status = CalendarsStatus.idle,
    this.calendars,
    this.selectedTabIndex,
    this.monthViewMode,
  });

  @override
  String toString() {
    return 'EventsState{' +
        ' status: ${status.name}' +
        ' calendars: $calendars,' +
        '}';
  }

  CalendarsState copyWith({
    CalendarsStatus? status,
    List<ViewCalendar>? Function()? calendars,
    int? selectedTabIndex,
    MonthViewMode? monthViewMode,
  }) {
    return CalendarsState(
        status: status ?? this.status,
        calendars: calendars == null ? this.calendars : calendars(),
        selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
        monthViewMode: monthViewMode ?? this.monthViewMode);
  }
}

enum CalendarsStatus { success, error, loading, idle }

extension CalendarsStatusX on CalendarsStatus {
  bool get isSuccess => this == CalendarsStatus.success;
  bool get isError => this == CalendarsStatus.error;
  bool get isLoading => this == CalendarsStatus.loading;
  bool get isIdle => this == CalendarsStatus.idle;
}
