import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/events_grid_builder.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarUseCaseImpl implements CalendarUseCase {
  final CalendarRepository repository;

  CalendarUseCaseImpl({required this.repository, tz.Location? location})
      : _location = location;

  DateTime? _selectedStartEventsInterval;
  DateTime? _selectedEndEventsInterval;
  tz.Location? _location;

  final BehaviorSubject<List<ViewCalendar>> _calendarsSubject =
      BehaviorSubject.seeded([]);

  final BehaviorSubject<List<ViewEvent>> _eventsSubject =
      BehaviorSubject.seeded([]);

  set setLocation(tz.Location? location) => _location = location;

  List<String> get selectedCalendarIds => _calendarsSubject.value
      .where((e) => e.selected)
      .map((e) => e.id)
      .toList();

  @override
  ValueStream<List<ViewCalendar>> get calendarsSubscription =>
      _calendarsSubject.stream;

  @override
  ValueStream<List<ViewEvent>> get eventsSubscription => _eventsSubject.stream;

  @override
  Future<void> createCalendar(CalendarCreationData data) async {
    final addedCalendar = await repository.createCalendar(data);
    _calendarsSubject
        .add([..._calendarsSubject.value, addedCalendar.toViewCalendar()]);
  }

  @override
  Future<void> getCalendars() async {
    final calendars = await repository.getCalendars();
    final calendarViews = calendars.map((e) => e.toViewCalendar()).toList();
    if (_calendarsSubject.value.isEmpty) {
      _calendarsSubject.add(calendarViews);
      return;
    }
    final lastSelectedIds = _calendarsSubject.value
        .where((e) => e.selected)
        .map((e) => e.id)
        .toSet();
    _calendarsSubject.add(calendarViews
        .map((e) => lastSelectedIds.contains(e.id)
            ? e.updateSelect(true)
            : e.updateSelect(false))
        .toList());
  }

  @override
  Future<void> getForPeriod(
      {required DateTime start, required DateTime end}) async {
    _selectedEndEventsInterval = end;
    _selectedStartEventsInterval = start;
    await _getLocalEvents();
  }

  @override
  Future<void> syncCalendars() async {
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
  Future<void> updateCalendar(ViewCalendar calendar) async {
    final calendars = [..._calendarsSubject.value];
    final updatableCalendar = calendars.firstWhere((e) => e.id == calendar.id);
    if (!updatableCalendar.updated(calendar)) {
      return;
    };
    await repository.updateCalendar(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
    _getLocalEvents();
  }

  @override
  Future<void> updateCalendarPublic(ViewCalendar calendar) async {
    final calendars = [..._calendarsSubject.value];
    final updatableCalendar = calendars.firstWhere((e) => e.id == calendar.id);
    if (!updatableCalendar.updated(calendar)) {
      return;
    };
    await repository.updateCalendarPublic(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
  }

  Future<void> _getLocalEvents() async {
    if (_selectedStartEventsInterval == null ||
        _selectedEndEventsInterval == null)
      throw Exception('Select date interval');
    final allEvents = await repository.getForPeriod(
      start: _selectedStartEventsInterval!,
      end: _selectedEndEventsInterval!,
      calendarIds: selectedCalendarIds,
    );
    final eventViews = allEvents
        .map((e) => ViewEvent.tryFromEvent(
              e,
              color: _calendarsSubject.value
                  .firstWhere((c) => c.id == e.calendarId)
                  .color,
            ))
        .whereNotNull()
        .map(
          (e) => e.copyWith(
            startDate: _location == null
                ? e.startDate
                : tz.TZDateTime.from(e.startDate, _location!),
            endDate: _location == null
                ? e.endDate
                : tz.TZDateTime.from(e.endDate, _location!),
          ),
        )
        .toList();

    _eventsSubject.add(eventViews);
  }

  @override
  Future<void> createEvent(EventCreationData data) async {
    await repository.createEvent(data.copyWith(
        startDate: _location == null
            ? data.startDate
            : tz.TZDateTime.from(data.startDate, _location!),
        endDate: _location == null
            ? data.endDate
            : tz.TZDateTime.from(data.endDate, _location!)));
    await syncCalendars();
    if (_selectedEndEventsInterval != null &&
        _selectedStartEventsInterval != null &&
        selectedCalendarIds.contains(data.calendarId)) {
      await _getLocalEvents();
    }
  }

  @override
  Future<ViewEvent> updateEvent(ViewEvent event) async {
    final model = await repository.updateEvent(event.copyWith(
        startDate: _location == null
            ? event.startDate
            : tz.TZDateTime.from(event.startDate, _location!),
        endDate: _location == null
            ? event.endDate
            : tz.TZDateTime.from(event.endDate, _location!)));
    syncCalendars().then((_) => _getLocalEvents());
    return ViewEvent.tryFromEvent(model, color: event.color)!;
  }

  @override
  Future<void> deleteEvent(ViewEvent event) async {
    await repository.deleteEvent(event);
    await syncCalendars();
    await _getLocalEvents();
  }

  @override
  Future<void> clearData() async {
    await repository.clearData();
    _eventsSubject.add([]);
    _calendarsSubject.add([]);
  }
}
