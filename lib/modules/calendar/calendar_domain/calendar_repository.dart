import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/calendar_repository_impl.dart';

abstract class CalendarRepository {
  factory CalendarRepository({
    required User user,
    required AppDatabase appDB,
  }) =>
      CalendarRepositoryImpl(
        appDB: appDB,
        user: user,
      );

  Future<void> syncCalendars();
}
