import 'dart:async';
import 'package:aurora_logger/aurora_logger.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_usecase.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/filters.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/models/displayable.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarUseCaseImpl implements CalendarUseCase {
  final CalendarRepository repository;

  CalendarUseCaseImpl({required this.repository, tz.Location? location})
      : _location = location;

  DateTime? _selectedStartEventsInterval;
  DateTime? _selectedEndEventsInterval;
  tz.Location? _location;
  ActivityFilter _tasksFilter = ActivityFilter();

  final BehaviorSubject<List<ViewCalendar>?> _calendarsSubject =
      BehaviorSubject.seeded(null);

  final BehaviorSubject<List<ViewEvent>?> _eventsSubject =
      BehaviorSubject.seeded(null);

  final BehaviorSubject<List<ViewTask>?> _tasksSubject =
      BehaviorSubject.seeded(null);

  set setLocation(tz.Location? location) => _location = location;

  List<String> get selectedCalendarIds => _calendarsSubject.value == null ? [] :
  _calendarsSubject.value!.where((e) => e.selected)
      .map((e) => e.id)
      .toList();

  @override
  ValueStream<List<ViewCalendar>?> get calendarsSubscription =>
      _calendarsSubject.stream;

  @override
  ValueStream<List<ViewEvent>?> get eventsSubscription => _eventsSubject.stream;

  @override
  ValueStream<List<ViewTask>?> get tasksSubscription => _tasksSubject.stream;

  @override
  Future<void> createCalendar(CalendarCreationData data) async {
    final addedCalendar = await repository.createCalendar(data);
    _calendarsSubject
        .add([...?_calendarsSubject.value, addedCalendar.toViewCalendar()]);
  }

  @override
  Future<void> getCalendars() async {
    final calendars = await repository.getCalendars();
    final calendarViews = calendars.map((e) => e.toViewCalendar()).toList();
    if (_calendarsSubject.value?.isEmpty ?? true) {
      _calendarsSubject.add(calendarViews);
      return;
    }
    final lastSelectedIds = _calendarsSubject.value == null ? <String>{} :
    _calendarsSubject.value!.where((e) => e.selected)
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
  Future<void> getTasks() async {
    await _getLocalTasks();
  }

  @override
  Future<void> fetchCalendars() async {
    try {
      await repository.syncCalendars();
    } catch (e, st) {
      logger.log('sync calendars error: ${e}');
    } finally {
      await getCalendars();
    }
  }

  @override
  Future<void> syncCalendarsWithActivities() async {
    try {
      await repository.syncCalendarsWithActivities();
    } catch (e, st) {
      rethrow;
    } finally {
      await getCalendars();
      await _getLocalEvents();
      await _getLocalTasks();
    }
  }

  @override
  void updateSelectedCalendarIds(
      {required String selectedId, bool isAdded = true}) {
    final calendars = [...?_calendarsSubject.value];
    int index = calendars.indexWhere((e) => e.id == selectedId);

    if (index != -1) {
      final selectedCalendar = calendars[index].updateSelect(isAdded);
      calendars[index] = selectedCalendar;
    }

    _calendarsSubject.add(calendars);
    _getLocalEvents();
  }

  @override
  void updateTasksFilter(ActivityFilter filter) {
    _tasksFilter = filter;
    _getLocalTasks();
  }

  @override
  Future<void> deleteCalendar(ViewCalendar calendar) async {
    await repository.deleteCalendar(calendar);
    _calendarsSubject
        .add([...?_calendarsSubject.value?.where((e) => e != calendar)]);
  }

  @override
  Future<void> unsubscribeFromCalendar(ViewCalendar calendar) async {
    _calendarsSubject
        .add([...?_calendarsSubject.value?.where((e) => e != calendar)]);
  }

  @override
  Future<void> updateCalendar(ViewCalendar calendar) async {
    final calendars = [...?_calendarsSubject.value];
    final updatableCalendar = calendars.firstWhere((e) => e.id == calendar.id);
    if (!updatableCalendar.updated(calendar)) {
      return;
    }
    ;
    await repository.updateCalendar(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
    _getLocalEvents();
    _getLocalTasks();
  }

  @override
  Future<void> updateCalendarPublic(ViewCalendar calendar) async {
    final calendars = [...?_calendarsSubject.value];
    final updatableCalendar = calendars.firstWhere((e) => e.id == calendar.id);
    if (!updatableCalendar.updated(calendar)) {
      return;
    }
    ;
    await repository.updateCalendarPublic(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
  }

  @override
  Future<void> updateCalendarSharing(ViewCalendar calendar) async {
    final calendars = [...?_calendarsSubject.value];
    final updatableCalendar = calendars.firstWhere((e) => e.id == calendar.id);
    if (!updatableCalendar.updated(calendar)) {
      return;
    }
    ;
    await repository.updateCalendarSharing(calendar);

    int index = calendars.indexWhere((e) => e.id == calendar.id);
    calendars[index] = calendar;
    _calendarsSubject.add(calendars);
  }

  Future<void> _getLocalEvents() async {
    if (_selectedStartEventsInterval == null ||
        _selectedEndEventsInterval == null) {
      _selectedStartEventsInterval = DateTime.now().firstDayOfMonth;
      _selectedEndEventsInterval = DateTime.now().lastDayOfMonth;
    }
    final allEvents = await repository.getEventsForPeriod(
      start: _selectedStartEventsInterval!,
      end: _selectedEndEventsInterval!,
      calendarIds: selectedCalendarIds,
    );
    final eventViews = allEvents
        .map((e) => ViewEvent.tryFromEvent(
              e,
              color: _calendarsSubject.value
                  !.firstWhere((c) => c.id == e.calendarId)
                  .color,
            ))
        .whereNotNull()
        .map(
          (e) => e.copyWith(
            startDate: () => _location == null
                ? e.startDate
                : tz.TZDateTime.from(e.startDate, _location!),
            endDate: () => _location == null
                ? e.endDate
                : tz.TZDateTime.from(e.endDate, _location!),
          ),
        )
        .toList();

    _eventsSubject.add(eventViews);
  }

  Future<void> _getLocalTasks() async {
    final allTasks = await repository.getTasks(_tasksFilter);
    final taskViews = allTasks
        .map((e) => e.toDisplayable(
              color: _calendarsSubject.value
                 !.firstWhere((c) => c.id == e.calendarId)
                  .color,
            ))
        .whereNotNull()
        .map(
          (e) => e.copyWith(
            startDate: _location == null || e.startDate == null
                ? () => e.startDate
                : () => tz.TZDateTime.from(e.startDate!, _location!),
            endDate: _location == null || e.endDate == null
                ? () => e.endDate
                : () => tz.TZDateTime.from(e.endDate!, _location!),
          ),
        )
        .toList();
    _tasksSubject.add(taskViews);
  }

  @override
  Future<void> createActivity(ActivityCreationData data) async {
    final endDate = data.allDay == true && data.endDate != null
        ? data.endDate!.add(Duration(days: 1))
        : data.endDate;
    await repository.createActivity(data.copyWith(
        startDate: _location == null || data.startDate == null
            ? () => data.startDate
            : () => convertToTZDateTime(data.startDate!, _location!),
        endDate: _location == null || endDate == null
            ? () => endDate
            : () => convertToTZDateTime(endDate, _location!)));
    await syncCalendarsWithActivities();
    if (_selectedEndEventsInterval != null &&
        _selectedStartEventsInterval != null &&
        data is EventCreationData &&
        selectedCalendarIds.contains(data.calendarId)) {
      await _getLocalEvents();
    }
    if (data is TaskCreationData) {
      await _getLocalTasks();
    }
  }

  @override
  Future<Displayable> getActivityByUid({required String calendarId, required String activityId}) async {
    final activity = await repository.getActivityByUid(calendarId: calendarId, activityUid: activityId);
    final displayable = activity.toDisplayable(color: Colors.red);
    //TODO add right color
    //TODO add right time
    return displayable!;
  }

  @override
  Future<Displayable> updateActivity(Displayable activity) async {
    final endDate = activity.allDay == true && activity.endDate != null
        ? activity.endDate!.add(Duration(days: 1))
        : activity.endDate;
    final model = await repository.updateActivity(activity.copyWith(
        startTS: _location == null || activity.startDate == null
            ? () => activity.startDate
            : () => convertToTZDateTime(activity.startDate!, _location!),
        endTS: _location == null || endDate == null
            ? () => endDate
            : () => convertToTZDateTime(endDate, _location!)));
    syncCalendarsWithActivities().then((_) {
      if (activity is Event) {
        _getLocalEvents();
      }
      if (activity is Task) {
        _getLocalTasks();
      }
    });
    final result = model.toDisplayable(color: activity.color);
    if (result == null)
      throw Exception('error .toDisplayable while updating activity');
    final resultEndDate = result.allDay == true && result.endDate != null
        ? result.endDate!.subtract(Duration(days: 1))
        : result.endDate;
    return result.copyWith(
      startDate: _location == null || result.startDate == null
          ? () => result.startDate
          : () => tz.TZDateTime.from(result.startDate!, _location!),
      endDate: _location == null || resultEndDate == null
          ? () => resultEndDate
          : () => tz.TZDateTime.from(resultEndDate, _location!),
    );
  }

  @override
  Future<void> deleteActivity(Activity activity) async {
    await repository.deleteActivity(activity);
    await syncCalendarsWithActivities();
    await _getLocalEvents();
  }

  @override
  Future<void> clearData() async {
    await repository.clearData();
    _eventsSubject.add(null);
    _tasksSubject.add(null);
    _calendarsSubject.add(null);
  }

  tz.TZDateTime convertToTZDateTime(DateTime date, tz.Location location) =>
      tz.TZDateTime(
          location, date.year, date.month, date.day, date.hour, date.minute);
}
