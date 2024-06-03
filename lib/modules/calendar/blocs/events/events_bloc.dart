import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventBlocEvent, EventsState> {
  final CalendarUseCase _useCase;

  EventsBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
          EventsState(
            startIntervalDate: DateTime.now().firstDayOfMonth,
            endIntervalDate: DateTime.now().lastDayOfMonth,
          ),
        ) {
    _useCase.eventsSubscription.listen((events) {
      add(AddEvents(events));
    });
    on<LoadEvents>(_onLoadEvents);
    on<CreateEvent>(_onCreateEvent);
    on<AddEvents>(_onAddEvents);
    on<StartSync>(_onStartSync);
    on<SelectDate>(_onSelectDate);
  }

  _onLoadEvents(LoadEvents event, emit) async {
    emit(state.copyWith(status: EventsStatus.loading));
    try {
      await _useCase.getForPeriod(
          start: state.startIntervalDate.withoutTime,
          end: state.endIntervalDate.startOfNextDay);
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onCreateEvent(CreateEvent event, emit) async {
    try {
      await _useCase.createEvent(
         event.creationData);
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onAddEvents(AddEvents event, emit) async {
    try {
      final splitEvents =
          event.events.expand((e) => e.splitIntoDailyEvents).toList();
      emit(state.copyWith(
          status: EventsStatus.success,
          splitEvents: () => splitEvents,
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
    if (state.selectedDate != null &&
        event.date.isAtSameMomentAs(state.selectedDate!)) {
      emit(state.copyWith(selectedDate: () => null));
      return;
    } else if (event.date.isBefore(state.startIntervalDate) ||
        event.date.isAfter(state.endIntervalDate)) {
      final newStartDate = event.date.firstDayOfMonth;
      final newEndDate = event.date.lastDayOfMonth;
      emit(state.copyWith(
          startIntervalDate: newStartDate, endIntervalDate: newEndDate));
      add(LoadEvents());
    }
    emit(state.copyWith(selectedDate: () => event.date));
  }
}
