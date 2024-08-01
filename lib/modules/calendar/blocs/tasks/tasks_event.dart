part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTask extends TasksEvent{
  final ViewTask task;
  const UpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateFilter extends TasksEvent{
  final ActivityFilter filter;
  const UpdateFilter(this.filter);
  @override
  List<Object?> get props => [filter];
}

class DeleteTask extends TasksEvent{
  const DeleteTask();
}

class SelectTask extends TasksEvent{
  final ViewTask? task;
  const SelectTask(this.task);
  @override
  List<Object?> get props => [task];
}

class AddTasks extends TasksEvent {
  final List<ViewTask>? tasks;
  const AddTasks(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class CreateTask extends TasksEvent{
  final TaskCreationData creationData;
  const CreateTask(this.creationData);
  @override
  List<Object?> get props => [creationData];
}

class LoadTasks extends TasksEvent{
  const LoadTasks();
}
