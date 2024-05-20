part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  @override
  List<Object?> get props => [];
}

class SelectDate extends EventsEvent{
 final DateTime date;
 const SelectDate(this.date);
}

class LoadEvents extends EventsEvent{
  const LoadEvents();
}

class StartSync extends EventsEvent{
  const StartSync();
}