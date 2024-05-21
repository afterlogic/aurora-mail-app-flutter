import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final CalendarRepository _calendarRepository;

  EventsBloc({required CalendarRepository calendarRepository})
      : _calendarRepository = calendarRepository,
        super(
          EventsState(
            startIntervalDate: DateTime.now().firstDayOfMonth,
            endIntervalDate: DateTime.now().lastDayOfMonth,
            // startIntervalDate: DateTime(1970, 1),
            // endIntervalDate: DateTime(2025),
          ),
        ) {
    on<LoadEvents>(_onLoadEvents);
    on<StartSync>(_onStartSync);
    on<SelectDate>(_onSelectDate);
  }

  _onLoadEvents(LoadEvents event, emit) async {
    emit(state.copyWith(status: EventsStatus.loading));
    try {
      final eventModels = await _calendarRepository.getForPeriod(
          start: state.startIntervalDate.withoutTime,
          end: state.endIntervalDate.startOfNextDay);
      final eventViews = eventModels
          .map((e) => ViewEvent.tryFromEvent(e))
          .whereNotNull()
          .toList();
      final splitEvents = eventViews.expand((e) => e.splitIntoDailyEvents).toList();
      emit(state.copyWith(
          status: EventsStatus.success, events: () => splitEvents));
    } catch (e, st) {
      emit(state.copyWith(status: EventsStatus.error));
    } finally {
      emit(state.copyWith(status: EventsStatus.idle));
    }
  }

  _onStartSync(StartSync event, emit) async {
    try {
      _calendarRepository.syncCalendars();
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
