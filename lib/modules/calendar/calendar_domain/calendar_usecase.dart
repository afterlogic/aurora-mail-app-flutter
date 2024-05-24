import 'package:aurora_mail/modules/calendar/calendar_domain/calendar_repository.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_usecase_impl.dart';

abstract class CalendarUseCase {
  factory CalendarUseCase({
    required CalendarRepository repository
  }) =>
      CalendarUseCaseImpl(
        repository: repository,
      );



  Future<void> syncCalendars();

  Future<List<Event>> getForPeriod({required DateTime start, required DateTime end});

  Future<Calendar> createCalendar(CalendarCreationData data);

  Future<List<Calendar>> getCalendars();

  ///returns update list of selected ids
  List<String> updateSelectedCalendarIds({required String selectedId, bool isAdded = true});

}
