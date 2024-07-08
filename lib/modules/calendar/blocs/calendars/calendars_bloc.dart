import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/views/month_view.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendars_event.dart';
part 'calendars_state.dart';

class CalendarsBloc extends Bloc<CalendarsEvent, CalendarsState> {
  final CalendarUseCase _useCase;
  late final StreamSubscription _subscription;

  CalendarsBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
          CalendarsState(),
        ) {
    _subscription = _useCase.calendarsSubscription.listen((value) {
      add(AddCalendars(value));
    });
    on<CreateCalendar>(_onCreateCalendar);
    on<SaveTabIndex>(_onSaveTabIndex);
    on<SaveMonthViewMode>(_onSaveMonthViewMode);
    on<GetCalendars>(_onGetCalendars);
    on<ClearData>(_onClearData);
    on<AddCalendars>(_onAddCalendars);
    on<DeleteCalendar>(_onDeleteCalendar);
    on<UpdateCalendar>(_onUpdateCalendar);
    on<UpdateCalendarSelection>(_onUpdateCalendarSelection);
  }

  @override
  close() async {
    _subscription.cancel();
    super.close();
  }

  _onAddCalendars(AddCalendars event, Emitter<CalendarsState> emit) async {
    emit(state.copyWith(calendars: () => event.calendars));
  }

  _onClearData(ClearData event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(_useCase.clearData, emit);
  }

  _onSaveTabIndex(SaveTabIndex event, Emitter<CalendarsState> emit) async {
    emit(state.copyWith(selectedTabIndex: event.index));
  }

  _onSaveMonthViewMode(
      SaveMonthViewMode event, Emitter<CalendarsState> emit) async {
    emit(state.copyWith(monthViewMode: event.mode));
  }

  _onCreateCalendar(CreateCalendar event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(() => _useCase.createCalendar(event.creationData), emit);
  }

  _onGetCalendars(GetCalendars event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(_useCase.getCalendars, emit);
  }

  _onDeleteCalendar(DeleteCalendar event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(() => _useCase.deleteCalendar(event.calendar), emit);
  }

  _onUpdateCalendarSelection(
      UpdateCalendarSelection event, Emitter<CalendarsState> emit) async {
    _errorHandler(
        () => _useCase.updateSelectedCalendarIds(
            selectedId: event.calendarId, isAdded: event.selected),
        emit);
  }

  _onUpdateCalendar(UpdateCalendar event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(() async => _useCase.updateCalendar(event.calendar), emit);
  }

  _errorHandler(void Function() callback, Emitter<CalendarsState> emit) {
    try {
      callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: CalendarsStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle, error: () => null));
    }
  }

  _asyncErrorHandler(
      Future Function() callback, Emitter<CalendarsState> emit) async {
    try {
      await callback();
    } catch (e, s) {
      emit(state.copyWith(
          status: CalendarsStatus.error, error: () => formatError(e, s)));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle, error: () => null));
    }
  }
}
