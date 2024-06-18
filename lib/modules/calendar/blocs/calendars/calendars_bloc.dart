import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/views/month_view.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendars_event.dart';
part 'calendars_state.dart';

class CalendarsBloc extends Bloc<CalendarsEvent, CalendarsState> {
  final CalendarUseCase _useCase;

  CalendarsBloc({required CalendarUseCase useCase})
      : _useCase = useCase,
        super(
          CalendarsState(),
        ) {
    _useCase.calendarsSubscription.listen((value) {
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

  _onAddCalendars(AddCalendars event, emit) async {
    emit(state.copyWith(calendars: () => event.calendars));
  }

  _onClearData(ClearData event, emit) async {
    await _useCase.clearData();
  }

  _onSaveTabIndex(SaveTabIndex event, emit) async {
    emit(state.copyWith(selectedTabIndex: event.index));
  }

  _onSaveMonthViewMode(SaveMonthViewMode event, emit) async {
    emit(state.copyWith(monthViewMode: event.mode));
  }

  _onCreateCalendar(CreateCalendar event, emit) async {
    try {
      await _useCase.createCalendar(event.creationData);
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }

  _onGetCalendars(GetCalendars event, emit) async {
    try {
      await _useCase.getCalendars();
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }

  _onDeleteCalendar(DeleteCalendar event, emit) async {
    try {
      _useCase.deleteCalendar(event.calendar);
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }

  _onUpdateCalendarSelection(UpdateCalendarSelection event, emit) async {
    _useCase.updateSelectedCalendarIds(
        selectedId: event.calendarId, isAdded: event.selected);
  }

  _onUpdateCalendar(UpdateCalendar event, emit) async {
    try {
      _useCase.updateCalendar(event.calendar);
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }
}
