import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:aurora_mail/modules/calendar/utils/events_grid_builder.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventBlocEvent, EventsState> {
  final CalendarUseCase _useCase;

  ///used for handling events from "out of month" days
  final extraDuration = Duration(days: 7);

  EventsBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
          EventsState(
            startIntervalDate: DateTime.now().firstDayOfMonth,
            endIntervalDate: DateTime.now().lastDayOfMonth,
            selectedDate: DateTime.now().withoutTime,
          ),
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

  _onSelectEvent(SelectEvent event, emit) async {
    emit(state.copyWith(selectedEvent: () => event.event));
  }

  _onUpdateEvent(UpdateEvent event, emit) async {
    try {
      final updatedEvent = await _useCase.updateActivity(event.event);
      emit(state.copyWith(selectedEvent: () => updatedEvent as ViewEvent));
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onDeleteEvent(DeleteEvent event, emit) async {
    try {
      await _useCase.deleteEvent(state.selectedEvent!);
      emit(state.copyWith(selectedEvent: () => null));
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onLoadEvents(LoadEvents event, emit) async {
    emit(state.copyWith(status: EventsStatus.loading));
    try {
      await _useCase.getForPeriod(
          start: state.startIntervalDate.withoutTime.subtract(extraDuration),
          end: state.endIntervalDate.startOfNextDay.add(extraDuration));
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onCreateEvent(CreateEvent event, emit) async {
    try {
      await _useCase.createActivity(event.creationData);
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onAddEvents(AddEvents event, emit) async {
    try {
      final weeks = generateWeeks(
          state.startIntervalDate.subtract(extraDuration),
          state.endIntervalDate.add(extraDuration));
      final processedEvents = processEvents(
          weeks,
          event.events
              .map((e) => ExtendedMonthEvent.fromViewEvent(e))
              .toList());
      final viewEvents = convertWeeksToMap(processedEvents);

      emit(state.copyWith(
          status: EventsStatus.success,
          eventsMap: () => viewEvents,
          originalEvents: () => event.events));
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onStartSync(StartSync event, emit) async {
    try {
      await _useCase.syncCalendars();
      add(LoadEvents());
    } catch (e, st) {
      print(e);
      print(st);
    }
  }

  _onSelectDate(SelectDate event, emit) async {
    if (event.date.isAtSameMomentAs(state.selectedDate)) {
      emit(state.copyWith(selectedDate: DateTime.now()));
      return;
    } else if (event.date.isBefore(state.startIntervalDate) ||
        event.date.isAfter(state.endIntervalDate)) {
      final newStartDate = event.date.firstDayOfMonth;
      final newEndDate = event.date.lastDayOfMonth;
      emit(state.copyWith(
          startIntervalDate: newStartDate, endIntervalDate: newEndDate));
      add(LoadEvents());
    }
    emit(state.copyWith(selectedDate: event.date));
  }
}
