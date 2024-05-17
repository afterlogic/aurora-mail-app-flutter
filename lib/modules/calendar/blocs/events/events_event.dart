part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  @override
  List<Object?> get props => [];
}

class SelectDate extends EventsEvent{
 const SelectDate();
}

class LoadEvents extends EventsEvent{
  const LoadEvents();
}

class StartSync extends EventsEvent{
  const StartSync();
}