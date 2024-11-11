import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/views/month_view.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
    on<UnsubscribeFromCalendar>(_onUnsubscribeFromCalendar);
    on<SaveTabIndex>(_onSaveTabIndex);
    on<SaveMonthViewMode>(_onSaveMonthViewMode);
    on<GetCalendars>(_onGetCalendars);
    on<FetchCalendars>(_onFetchCalendars);
    on<ClearData>(_onClearData);
    on<AddCalendars>(_onAddCalendars);
    on<DeleteCalendar>(_onDeleteCalendar);
    on<UpdateCalendar>(_onUpdateCalendar);
    on<UpdateCalendarPublic>(_onUpdateCalendarPublic);
    on<UpdateCalendarShares>(_onUpdateCalendarShares);
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
    await _asyncErrorHandler(() async{
      await _useCase.clearData();
    }, emit);
  }

  _onSaveTabIndex(SaveTabIndex event, Emitter<CalendarsState> emit) async {
    emit(state.copyWith(selectedTabIndex: event.index));
  }

  _onSaveMonthViewMode(
      SaveMonthViewMode event, Emitter<CalendarsState> emit) async {
    emit(state.copyWith(monthViewMode: event.mode));
  }

  _onCreateCalendar(CreateCalendar event, Emitter<CalendarsState> emit) async {
    await _asyncErrorHandler(() async{
      await _useCase.createCalendar(event.creationData);
    }, emit);
  }

  _onUnsubscribeFromCalendar(UnsubscribeFromCalendar event, Emitter<CalendarsState> emit) async {
    await _asyncErrorHandler(() async{
      await _useCase.unsubscribeFromCalendar(event.calendar);
    }, emit);
  }

  _onFetchCalendars(FetchCalendars event, Emitter<CalendarsState> emit) async {
    await _asyncErrorHandler(() async{
      await _useCase.fetchCalendars();
    }, emit);
  }

  _onGetCalendars(GetCalendars event, Emitter<CalendarsState> emit) async {
    await _asyncErrorHandler(() async{
      await _useCase.getCalendars();
    }, emit);
  }

  _onDeleteCalendar(DeleteCalendar event, Emitter<CalendarsState> emit) async {
    await _asyncErrorHandler(() async{
      await _useCase.deleteCalendar(event.calendar);
    }, emit);
  }

  _onUpdateCalendarSelection(
      UpdateCalendarSelection event, Emitter<CalendarsState> emit) async {
    _errorHandler(
        () => _useCase.updateSelectedCalendarIds(
            selectedId: event.calendarId, isAdded: event.selected),
        emit);
  }

  _onUpdateCalendar(UpdateCalendar event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(
        () async => _useCase.updateCalendar(event.calendar), emit);
  }

  _onUpdateCalendarPublic(
      UpdateCalendarPublic event, Emitter<CalendarsState> emit) async {
    _asyncErrorHandler(
        () async => _useCase.updateCalendarPublic(
            event.calendar.copyWith(isPublic: !event.calendar.isPublic)),
        emit);
  }

  _onUpdateCalendarShares(
      UpdateCalendarShares event, Emitter<CalendarsState> emit) async {
    final calendarForUpdate =
        state.calendars?.firstWhereOrNull((e) => e.id == event.calendarId);
    if (calendarForUpdate == null) return;
    _asyncErrorHandler(
        () async => _useCase.updateCalendarSharing(
            calendarForUpdate.copyWith(shares: event.shares)),
        emit);
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
