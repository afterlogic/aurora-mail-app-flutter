import 'dart:async';

import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_usecase_impl.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:rxdart/streams.dart';

abstract class CalendarUseCase {
  factory CalendarUseCase({
    required CalendarRepository repository
  }) =>
      CalendarUseCaseImpl(
        repository: repository,
      );


  ValueStream<List<ViewCalendar>> get calendarsSubscription;

  Future<void> syncCalendars();

  Future<List<Event>> getForPeriod({required DateTime start, required DateTime end});

  Future<void> createCalendar(CalendarCreationData data);

  Future<void> deleteCalendar(ViewCalendar calendar);

  Future<void> getCalendars();

  void updateSelectedCalendarIds({required String selectedId, bool isAdded = true});
}
