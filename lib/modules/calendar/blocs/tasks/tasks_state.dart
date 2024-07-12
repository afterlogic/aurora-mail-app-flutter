part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final TasksStatus status;
  final List<ViewTask>? tasks;
  final ViewTask? selectedTask;


  const TasksState({
    this.status = TasksStatus.idle,
    this.tasks,
    this.selectedTask,
  });

  @override
  List<Object?> get props => [
        status,
        tasks,
        selectedTask,
      ];


  TasksState copyWith({
    TasksStatus? status,
    List<ViewTask>? Function()? tasks,
    ViewTask? Function()? selectedTask,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks:
      tasks == null ? this.tasks : tasks(),
      selectedTask:
      selectedTask == null ? this.selectedTask : selectedTask(),

    );
  }
}

enum TasksStatus { success, error, loading, idle }

extension TasksStatusX on TasksStatus {
  bool get isSuccess => this == TasksStatus.success;
  bool get isError => this == TasksStatus.error;
  bool get isLoading => this == TasksStatus.loading;
  bool get isIdle => this == TasksStatus.idle;
}
