part of 'calendars_bloc.dart';

abstract class CalendarsEvent extends Equatable {
  const CalendarsEvent();

  @override
  List<Object?> get props => [];
}

class CreateCalendar extends CalendarsEvent {
  final CalendarCreationData creationData;
  const CreateCalendar({required this.creationData});

  @override
  List<Object?> get props => [creationData];
}

class GetCalendars extends CalendarsEvent {
  const GetCalendars();
}

class UpdateCalendarSelection extends CalendarsEvent {
  final bool selected;
  final String calendarId;
  const UpdateCalendarSelection({required this.calendarId, required this.selected});

  @override
  List<Object?> get props => [selected, calendarId];
}
