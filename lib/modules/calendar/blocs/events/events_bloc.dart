import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:bloc/bloc.dart';
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
            // selectedStartDate:
            //     DateTime(DateTime.now().year, DateTime.now().month),
            // selectedEndDate:
            //     DateTime(DateTime.now().year, DateTime.now().month).add(
            //   Duration(days: 32),
            selectedStartDate: DateTime(1970, 1),
            selectedEndDate: DateTime(2025),
          ),
        ) {
    on<LoadEvents>(_onLoadEvents);
    on<StartSync>(_onStartSync);
  }

  _onLoadEvents(LoadEvents event, emit) async {
    emit(state.copyWith(status: EventsStatus.loading));
    try {
      final eventModels = await _calendarRepository.getForPeriod(
          start: state.selectedStartDate, end: state.selectedEndDate);
      final eventViews = eventModels
          .map((e) => ViewEvent.tryFromEvent(e))
          .whereNotNull()
          .toList();
      emit(state.copyWith(
          status: EventsStatus.success, events: () => eventViews));
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
}
