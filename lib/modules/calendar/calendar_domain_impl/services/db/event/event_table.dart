import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:drift/drift.dart';

@DataClassName("EventDb")
class EventTable extends Table {

  @override
  Set<Column> get primaryKey => {uid, userLocalId, calendarId};

  TextColumn get organizer => text().nullable()();

  BoolColumn get appointment => boolean().nullable()();

  IntColumn get appointmentAccess => integer().nullable()();

  TextColumn get calendarId => text()();

  IntColumn get userLocalId => integer()();

  TextColumn get uid => text()();

  TextColumn get subject => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get location => text().nullable()();

  DateTimeColumn get startTS => dateTime().nullable()();

  DateTimeColumn get endTS => dateTime().nullable()();

  BoolColumn get allDay => boolean().nullable()();

  TextColumn get owner => text().nullable()();

  BoolColumn get modified => boolean().nullable()();

  IntColumn get recurrenceId => integer().nullable()();

  IntColumn get lastModified => integer().nullable()();

  // TODO add rrule

  BoolColumn get status => boolean().nullable()();

  BoolColumn get withDate => boolean().nullable()();

  BoolColumn get isPrivate => boolean().nullable()();

  IntColumn get updateStatus => intEnum<UpdateStatus>()();

  BoolColumn get synced =>  boolean()();

  BoolColumn get onceLoaded =>  boolean()();
}
