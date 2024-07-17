import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final CalendarUseCase _useCase;

  // TODO dispose subscription, object exists only on one page

  TasksBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
        TasksState( ),
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

  _onSelectTask(SelectTask event, emit) async {
    emit(state.copyWith(selectedTask: () => event.task));
  }

  _onUpdateTask(UpdateTask event, emit) async {
    try {
      final updatedTask = await _useCase.updateActivity(event.task);
      emit(state.copyWith(selectedTask: () => updatedTask as ViewTask));
    } catch (e, st) {
      emit(state.copyWith(status: TasksStatus.error));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle));
    }
  }

  _onUpdateFilter(UpdateFilter event, emit) async {
    if(state.filter == event.filter) return;
    emit(state.copyWith(filter: event.filter));
    _useCase.updateTasksFilter(event.filter);
  }

  _onDeleteTask(DeleteTask event, emit) async {
    try {
      // await _useCase.deleteEvent(state.selectedTask!);
      emit(state.copyWith(selectedTask: () => null));
    } catch (e, st) {
      emit(state.copyWith(status: TasksStatus.error));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle));
    }
  }

  _onLoadTasks(LoadTasks event, emit) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      _useCase.getTasks();
     } catch (e, st) {
      emit(state.copyWith(status: TasksStatus.error));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle));
    }
  }

  _onCreateTask(CreateTask event, emit) async {
    try {
      await _useCase.createActivity(event.creationData);
    } catch (e, st) {
      emit(state.copyWith(status: TasksStatus.error));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle));
    }
  }

  _onAddTasks(AddTasks event, emit) async {
    try {
      emit(state.copyWith(
          status: TasksStatus.success,
          tasks: () => event.tasks
          ));
    } catch (e, st) {
      emit(state.copyWith(status: TasksStatus.error));
    } finally {
      emit(state.copyWith(status: TasksStatus.idle));
    }
  }


}
