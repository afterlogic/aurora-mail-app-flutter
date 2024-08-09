part of 'events_bloc.dart';

abstract class EventBlocEvent extends Equatable {
  const EventBlocEvent();
  @override
  List<Object?> get props => [];
}

class SelectDate extends EventBlocEvent {
  final bool isWeekChanged;
  final DateTime date;
  const SelectDate(this.date, {this.isWeekChanged = false});
  @override
  List<Object?> get props => [date, isWeekChanged];
}

class UpdateEvent extends EventBlocEvent {
  final ViewEvent event;
  const UpdateEvent(this.event);
  @override
  List<Object?> get props => [event];
}

class DeleteEvent extends EventBlocEvent {
  const DeleteEvent();
}

class SelectEvent extends EventBlocEvent {
  final ViewEvent? event;
  const SelectEvent(this.event);
  @override
  List<Object?> get props => [event];
}

class AddEvents extends EventBlocEvent {
  final List<ViewEvent>? events;
  const AddEvents(this.events);
  @override
  List<Object?> get props => [events];
}

class CreateEvent extends EventBlocEvent {
  final EventCreationData creationData;
  const CreateEvent(this.creationData);
  @override
  List<Object?> get props => [creationData];
}

class LoadEvents extends EventBlocEvent {
  const LoadEvents();
}

class StartSync extends EventBlocEvent {
  const StartSync();
}
