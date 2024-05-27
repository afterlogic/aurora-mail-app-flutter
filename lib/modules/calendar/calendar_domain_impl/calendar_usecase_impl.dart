import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:rxdart/rxdart.dart';

class CalendarUseCaseImpl implements CalendarUseCase {
  final CalendarRepository repository;

  CalendarUseCaseImpl({required this.repository});

  DateTime? _selectedStartEventsInterval;
  DateTime? _selectedEndEventsInterval;
  final BehaviorSubject<List<ViewCalendar>> _calendarsSubject = BehaviorSubject.seeded([]);

  @override
  Future<void> createCalendar(CalendarCreationData data) async {
    final addedCalendar = await repository.createCalendar(data);
    _calendarsSubject.add([..._calendarsSubject.value, addedCalendar.toViewCalendar()]);
  }

  @override
  Future<void> getCalendars() async{
    final calendars = await repository.getCalendars();
    _calendarsSubject.add(calendars.map((e) => e.toViewCalendar()).toList());
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
  void updateSelectedCalendarIds({required String selectedId, bool isAdded = true}) {
    final calendars = [..._calendarsSubject.value];
    int index = calendars.indexWhere((e) => e.id == selectedId);

    if (index != -1) {
      final selectedCalendar = calendars[index].updateSelect(isAdded);
      calendars[index] = selectedCalendar;
    }

    _calendarsSubject.add(calendars);
    // TODO: update stream of events
  }

  @override
  Future<void> deleteCalendar(ViewCalendar calendar) async{
    await repository.deleteCalendar(calendar);
    _calendarsSubject.add([..._calendarsSubject.value.where((e) => e != calendar)]);
  }

  @override
  ValueStream<List<ViewCalendar>> get calendarsSubscription => _calendarsSubject.stream;
}
