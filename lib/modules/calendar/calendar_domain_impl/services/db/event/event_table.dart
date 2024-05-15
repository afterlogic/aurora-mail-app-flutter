import 'package:drift/drift.dart';

@DataClassName("EventDb")
class EventTable extends Table {

  @override
  Set<Column> get primaryKey => {id, userLocalId};

  TextColumn get organizer => text()();

  BoolColumn get appointment => boolean()();

  IntColumn get appointmentAccess => integer()();

  TextColumn get calendarId => text()();

  IntColumn get userLocalId => integer()();

  TextColumn get id => text()();

  TextColumn get uid => text()();

  TextColumn get subject => text().nullable()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get startTS => dateTime()();

  DateTimeColumn get endTS => dateTime().nullable()();

  BoolColumn get allDay => boolean()();

  TextColumn get owner => text()();

  BoolColumn get modified => boolean()();

  IntColumn get recurrenceId => integer()();

  IntColumn get lastModified => integer()();

  // TODO add rrule

  BoolColumn get status => boolean()();

  BoolColumn get withDate => boolean()();

  BoolColumn get isPrivate => boolean()();
}
