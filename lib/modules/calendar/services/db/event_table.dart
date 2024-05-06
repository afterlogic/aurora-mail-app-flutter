import 'package:drift/drift.dart';

@DataClassName("EventDb")
class EventTable extends Table{

  IntColumn get localId => integer().autoIncrement()();

  IntColumn get userLocalId => integer()();

  TextColumn get calendarId => text()();

  DateTimeColumn get startTS => dateTime()();

  DateTimeColumn get endTS => dateTime().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get name => text().nullable()();

  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();

}

