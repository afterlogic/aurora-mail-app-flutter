import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class CalendarUseCaseImpl implements CalendarUseCase {
  final CalendarRepository repository;

  CalendarUseCaseImpl({required this.repository});

  DateTime? _selectedStartEventsInterval;
  DateTime? _selectedEndEventsInterval;

  final BehaviorSubject<List<ViewCalendar>> _calendarsSubject =
      BehaviorSubject.seeded([]);

  final BehaviorSubject<List<VisibleDayEvent>> _eventsSubject =
      BehaviorSubject.seeded([]);

  List<String> get selectedCalendarIds => _calendarsSubject.value
      .where((e) => e.selected)
      .map((e) => e.id)
      .toList();

  @override
  ValueStream<List<ViewCalendar>> get calendarsSubscription =>
      _calendarsSubject.stream;

  @override
  ValueStream<List<VisibleDayEvent>> get eventsSubscription =>
      _eventsSubject.stream;

  @override
  Future<void> createCalendar(CalendarCreationData data) async {
    final addedCalendar = await repository.createCalendar(data);
    _calendarsSubject
        .add([..._calendarsSubject.value, addedCalendar.toViewCalendar()]);
  }

  @override
  Future<void> getCalendars() async {
    final calendars = await repository.getCalendars();
    _calendarsSubject.add(calendars.map((e) => e.toViewCalendar()).toList());
  }

  @override
  Future<void> getForPeriod(
      {required DateTime start, required DateTime end}) async {
    _selectedEndEventsInterval = end;
    _selectedStartEventsInterval = start;
    await _getLocalEvents();
  }

  @override
  Future<void> syncCalendars() async{
    await repository.syncCalendars();
    await getCalendars();
  }

  @override
  void updateSelectedCalendarIds(
      {required String selectedId, bool isAdded = true}) {
    final calendars = [..._calendarsSubject.value];
    int index = calendars.indexWhere((e) => e.id == selectedId);

    if (index != -1) {
      final selectedCalendar = calendars[index].updateSelect(isAdded);
      calendars[index] = selectedCalendar;
    }

    _calendarsSubject.add(calendars);
    _getLocalEvents();
  }

  @override
  Future<void> deleteCalendar(ViewCalendar calendar) async {
    await repository.deleteCalendar(calendar);
    _calendarsSubject
        .add([..._calendarsSubject.value.where((e) => e != calendar)]);
  }

  @override
  Future<void> updateCalendar(ViewCalendar calendar) async{
    final calendars = [..._calendarsSubject.value];
    final updatableCalendar =
      calendars.firstWhere((e) => e.id == calendar.id);
    if(!updatableCalendar.updated(calendar)){
      return;
    };
    await repository.updateCalendar(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
    _getLocalEvents();
  }

  Future _getLocalEvents() async {
    if (_selectedStartEventsInterval == null ||
        _selectedEndEventsInterval == null)
      throw Exception('Select date interval');
    final allEvents = await repository.getForPeriod(
      start: _selectedStartEventsInterval!,
      end: _selectedEndEventsInterval!,
      calendarIds: selectedCalendarIds,
    );
    final eventViews = allEvents
        .map((e) => VisibleDayEvent.tryFromEvent(e,
            color: _calendarsSubject.value
                .firstWhere((c) => c.id == e.calendarId)
                .color))
        .whereNotNull()
        .toList();
    _eventsSubject.add(eventViews);
  }
}
