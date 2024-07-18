import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final CalendarUseCase _useCase;

  TasksBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
          TasksState(),
        ) {
    _useCase.tasksSubscription.listen((tasks) {
      add(AddTasks(tasks));
    });
    on<LoadTasks>(_onLoadTasks);
    on<CreateTask>(_onCreateTask);
    on<AddTasks>(_onAddTasks);
    on<SelectTask>(_onSelectTask);
    on<UpdateTask>(_onUpdateTask);
    on<UpdateFilter>(_onUpdateFilter);
    on<DeleteTask>(_onDeleteTask);
  }

  _onSelectTask(SelectTask event, Emitter<TasksState> emit) async {
    emit(state.copyWith(selectedTask: () => event.task));
  }

  _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    _asyncErrorHandler(() async {
      final updatedTask = await _useCase.updateActivity(event.task);
      emit(state.copyWith(selectedTask: () => updatedTask as ViewTask));
    }, emit);
  }

  _onUpdateFilter(UpdateFilter event, Emitter<TasksState> emit) async {
    if (state.filter == event.filter) return;
    emit(state.copyWith(filter: event.filter));
    _useCase.updateTasksFilter(event.filter);
  }

  _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    _asyncErrorHandler(() async {
      await _useCase.deleteActivity(state.selectedTask!);
      emit(state.copyWith(selectedTask: () => null));
    }, emit);
  }

  _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    _asyncErrorHandler(() async {
      await _useCase.getTasks();
    }, emit);
  }

  _onCreateTask(CreateTask event, Emitter<TasksState> emit) async {
    _asyncErrorHandler(() async {
      await _useCase.createActivity(event.creationData);
    }, emit);
  }

  _onAddTasks(AddTasks event, Emitter<TasksState> emit) async {
    _errorHandler(() {
      emit(state.copyWith(
          status: TasksStatus.success, tasks: () => event.tasks));
    }, emit);
  }

  _errorHandler(void Function() callback, Emitter<TasksState> emit) {
    try {
      callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: TasksStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle, error: () => null));
    }
  }

  _asyncErrorHandler(
      Future Function() callback, Emitter<TasksState> emit) async {
    try {
      await callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: TasksStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle, error: () => null));
    }
  }
}
