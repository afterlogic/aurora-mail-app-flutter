part of 'events_bloc.dart';

abstract class EventBlocEvent extends Equatable {
  const EventBlocEvent();
  @override
  List<Object?> get props => [];
}

class SelectDate extends EventBlocEvent{
 final DateTime date;
 const SelectDate(this.date);
 @override
 List<Object?> get props => [date];
}

class LoadEvents extends EventBlocEvent{
  const LoadEvents();
}

class StartSync extends EventBlocEvent{
  const StartSync();
}