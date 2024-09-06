import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:aurora_mail/modules/calendar/utils/events_grid_builder.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventBlocEvent, EventsState> {
  final CalendarUseCase _useCase;

  // @override
  // void onEvent(event) {
  //   logger.log("EventsBloc event ${event.runtimeType}");
  //   super.onEvent(event);
  // }
  // @override
  // void onChange(Change<EventsState> change) {
  //   logger.log("EventsBloc change ${change}");
  //   super.onChange(change);
  // }

  ///used for handling events from "out of month" days
  final extraDuration = Duration(days: 7);

  EventsBloc({required CalendarUseCase useCase, required int firstDayInWeek})
      : _useCase = useCase,
        super(
          EventsState(
              startIntervalDate: DateTime.now().firstDayOfMonth,
              endIntervalDate: DateTime.now().lastDayOfMonth,
              selectedDate: DateTime.now().withoutTime,
              firstDayInWeek: firstDayInWeek),
        ) {
    _useCase.eventsSubscription.listen((events) {
      add(AddEvents(events));
    });
    on<LoadEvents>(_onLoadEvents);
    on<CreateEvent>(_onCreateEvent);
    on<AddEvents>(_onAddEvents);
    on<SelectEvent>(_onSelectEvent);
    on<UpdateEvent>(_onUpdateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<StartSync>(_onStartSync);
    on<SelectDate>(_onSelectDate);
  }

  _onSelectEvent(SelectEvent event, Emitter<EventsState> emit) async {
    emit(state.copyWith(selectedEvent: () => event.event));
  }

  _onUpdateEvent(UpdateEvent event, Emitter<EventsState> emit) async {
    await _asyncErrorHandler(() async {
      final updatedEvent = await _useCase.updateActivity(event.event,
          state.selectedEvent?.calendarId ?? event.event.calendarId);
      emit(state.copyWith(selectedEvent: () => updatedEvent as ViewEvent));
    }, emit);
  }

  _onDeleteEvent(DeleteEvent event, Emitter<EventsState> emit) async {
    await _asyncErrorHandler(() async {
      await _useCase.deleteActivity(state.selectedEvent!);
    }, emit);
  }

  _onLoadEvents(LoadEvents event, Emitter<EventsState> emit) async {
    await _asyncErrorHandler(() async {
      await _useCase.getForPeriod(
          start: state.startIntervalDate.withoutTime.subtract(extraDuration),
          end: state.endIntervalDate.startOfNextDay.add(extraDuration));
    }, emit);
  }

  _onCreateEvent(CreateEvent event, Emitter<EventsState> emit) async {
    await _asyncErrorHandler(() async {
      await _useCase.createActivity(event.creationData);
    }, emit);
  }

  _onAddEvents(AddEvents event, Emitter<EventsState> emit) async {
    if (event.events == null && state.status.isLoading) {
      return;
    }
    _errorHandler(() {
      final weeks = generateWeeks(
          state.startIntervalDate.subtract(extraDuration),
          state.endIntervalDate.add(extraDuration));
      final List<ExtendedMonthEvent> extendedMonthEvents = event.events == null
          ? []
          : event.events!
              .map((e) => ExtendedMonthEvent.fromViewEvent(e))
              .toList();
      final processedEvents = processEvents(weeks, extendedMonthEvents);
      final viewEvents = convertWeeksToMap(processedEvents);

      emit(state.copyWith(
          status: EventsStatus.success,
          eventsMap: () => viewEvents,
          originalEvents: () => event.events));
    }, emit);
  }

  _onStartSync(StartSync event, Emitter<EventsState> emit) async {
    if (state.originalEvents == null || state.eventsMap == null) {
      emit(state.copyWith(status: EventsStatus.loading));
    }
    await _asyncErrorHandler(() async {
      await _useCase.syncCalendarsWithActivities();
    }, emit);
  }

  _onSelectDate(SelectDate event, Emitter<EventsState> emit) async {
    final today = DateTime.now();
    if (event.date.isAtSameMomentAs(state.selectedDate)) {
      emit(state.copyWith(selectedDate: DateTime.now()));
      return;
    } else if (event.date.isBefore(state.startIntervalDate) ||
        event.date.isAfter(state.endIntervalDate)) {
      final newStartDate = event.date.firstDayOfMonth;
      final newEndDate = event.date.lastDayOfMonth;
      emit(state.copyWith(
          selectedDate:
              today.isBefore(newEndDate) && today.isAfter(newStartDate)
                  ? today
                  : event.date,
          startIntervalDate: newStartDate,
          endIntervalDate: newEndDate));
      add(LoadEvents());
      return;
    }
    final weekEnd =
        event.isWeekChanged ? event.date.add(Duration(days: 6)) : null;

    emit(state.copyWith(
        selectedDate: weekEnd != null &&
                today.isBefore(weekEnd) &&
                today.isAfter(event.date)
            ? today
            : event.date));
  }

  _errorHandler(void Function() callback, Emitter<EventsState> emit) {
    try {
      callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: EventsStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle, error: () => null));
    }
  }

  _asyncErrorHandler(
      Future Function() callback, Emitter<EventsState> emit) async {
    try {
      await callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: EventsStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle, error: () => null));
    }
  }
}
