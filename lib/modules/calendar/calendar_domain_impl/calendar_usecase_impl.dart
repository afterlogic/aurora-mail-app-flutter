import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';

class CalendarUseCaseImpl implements CalendarUseCase {
  final CalendarRepository repository;

  CalendarUseCaseImpl({required this.repository});

  List<String> _selectedCalendarIds = [];
  DateTime? _selectedStartEventsInterval;
  DateTime? _selectedEndEventsInterval;

  @override
  Future<Calendar> createCalendar(CalendarCreationData data) {
    return repository.createCalendar(data);
  }

  @override
  Future<List<Calendar>> getCalendars() {
    return repository.getCalendars();
  }

  @override
  Future<List<Event>> getForPeriod(
      {required DateTime start, required DateTime end}) {
    return repository.getForPeriod(start: start, end: end);
  }

  @override
  Future<void> syncCalendars() {
    return syncCalendars();
  }

  @override
  List<String> updateSelectedCalendarIds({required String selectedId, bool isAdded = true}) {
    if(isAdded){
      _selectedCalendarIds.add(selectedId);
    } else{
      _selectedCalendarIds.removeWhere((e) => e == selectedId);
    }

    return _selectedCalendarIds;
    // TODO: update stream of events

  }
}
