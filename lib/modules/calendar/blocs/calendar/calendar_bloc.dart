import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarBlocEvent, CalendarState> {
  final CalendarRepository _calendarRepository;

  CalendarBloc({required CalendarRepository calendarRepository})
      : _calendarRepository = calendarRepository,
        super(
          CalendarState(
            startIntervalDate: DateTime.now().firstDayOfMonth,
            endIntervalDate: DateTime.now().lastDayOfMonth,
          ),
        ) {
    on<LoadEvents>(_onLoadEvents);
    on<StartSync>(_onStartSync);
    on<SelectDate>(_onSelectDate);
    on<CreateCalendar>(_onCreateCalendar);
  }

  _onLoadEvents(LoadEvents event, emit) async {
    emit(state.copyWith(status: CalendarStatus.loading));
    try {
      final eventModels = await _calendarRepository.getForPeriod(
          start: state.startIntervalDate.withoutTime,
          end: state.endIntervalDate.startOfNextDay);
      final eventViews = eventModels
          .map((e) => ViewEvent.tryFromEvent(e))
          .whereNotNull()
          .toList();
      final splitEvents =
          eventViews.expand((e) => e.splitIntoDailyEvents).toList();
      emit(state.copyWith(
          status: CalendarStatus.success, events: () => splitEvents));
    } catch (e, st) {
      emit(state.copyWith(status: CalendarStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarStatus.idle));
    }
  }

  _onStartSync(StartSync event, emit) async {
    try {
      await _calendarRepository.syncCalendars();
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

  _onCreateCalendar(CreateCalendar event, emit) async {
    try {
      //TODO possible without sync
      emit(state.copyWith(status: CalendarStatus.loading));
      await _calendarRepository.createCalendar(event.creationData);
      await _calendarRepository.syncCalendars();
    } catch (e, s) {
      emit(state.copyWith(status: CalendarStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarStatus.idle));
    }
  }
}
