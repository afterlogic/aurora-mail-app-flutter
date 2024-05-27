part of 'calendars_bloc.dart';

class CalendarsState extends Equatable {
  final CalendarsStatus status;
  final List<ViewCalendar>? calendars;

  @override
  List<Object?> get props => [status,  calendars];



  const CalendarsState({
    this.status = CalendarsStatus.idle,
    this.calendars,
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
  }) {
    return CalendarsState(
      status: status ?? this.status,
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