import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
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
    on<CreateCalendar>(_onCreateCalendar);
    on<GetCalendars>(_onGetCalendars);
    on<UpdateCalendarSelection>(_onUpdateCalendarSelection);
  }

  _onCreateCalendar(CreateCalendar event, emit) async {
    try {
      final addedCalendar = await _useCase.createCalendar(event.creationData);
      emit(state.copyWith(
          calendars: () => [...?state.calendars, addedCalendar]));
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }

  _onGetCalendars(GetCalendars event, emit) async {
    try {
      final calendars = await _useCase.getCalendars();
      emit(state.copyWith(calendars: () => calendars));
    } catch (e, s) {
      emit(state.copyWith(status: CalendarsStatus.error));
    } finally {
      emit(state.copyWith(status: CalendarsStatus.idle));
    }
  }

  _onUpdateCalendarSelection(UpdateCalendarSelection event, emit) async {
    final updatedSelectedIds = _useCase.updateSelectedCalendarIds(
        selectedId: event.calendarId, isAdded: event.selected);
    emit(state.copyWith(selectedCalendarIds: updatedSelectedIds));
  }
}
