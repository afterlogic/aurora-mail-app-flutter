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

class ClearData extends CalendarsEvent {
  const ClearData();
}

class AddCalendars extends CalendarsEvent {

  final List<ViewCalendar> calendars;
  const AddCalendars(this.calendars);
  @override
  List<Object?> get props => [calendars];
}

class DeleteCalendar extends CalendarsEvent {
  final ViewCalendar calendar;
  const DeleteCalendar(this.calendar);

  @override
  List<Object?> get props => [calendar];
}

class UpdateCalendar extends CalendarsEvent {

  final ViewCalendar calendar;
  const UpdateCalendar(this.calendar);
  @override
  List<Object?> get props => [calendar];
}

class UpdateCalendarSelection extends CalendarsEvent {
  final bool selected;
  final String calendarId;
  const UpdateCalendarSelection({required this.calendarId, required this.selected});

  @override
  List<Object?> get props => [selected, calendarId];
}
