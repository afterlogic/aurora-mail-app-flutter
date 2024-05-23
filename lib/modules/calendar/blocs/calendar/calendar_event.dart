part of 'calendar_bloc.dart';

abstract class CalendarBlocEvent extends Equatable {
  const CalendarBlocEvent();
  @override
  List<Object?> get props => [];
}

class SelectDate extends CalendarBlocEvent{
 final DateTime date;
 const SelectDate(this.date);
 @override
 List<Object?> get props => [date];
}

class LoadEvents extends CalendarBlocEvent{
  const LoadEvents();
}

class StartSync extends CalendarBlocEvent{
  const StartSync();
}

class CreateCalendar extends CalendarBlocEvent{
  final CalendarCreationData creationData;
  const CreateCalendar({required this.creationData});
  @override
  List<Object?> get props => [creationData];
}