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

class AddEvents extends EventBlocEvent {

  final List<VisibleDayEvent> events;
  const AddEvents(this.events);
  @override
  List<Object?> get props => [events];
}

class CreateEvent extends EventBlocEvent{
  final EventCreationData creationData;
  const CreateEvent(this.creationData);
  @override
  List<Object?> get props => [creationData];
}

class LoadEvents extends EventBlocEvent{
  const LoadEvents();
}

class StartSync extends EventBlocEvent{
  const StartSync();
}