import 'package:drift/drift.dart';

@DataClassName("CalendarDb")
class CalendarTable extends Table{

  @override
  Set<Column> get primaryKey => {id, userLocalId};

  TextColumn get id => text()();

  TextColumn get color => text()();

  TextColumn get description => text().nullable()();

  IntColumn get userLocalId => integer()();

  TextColumn get name => text()();

  TextColumn get owner => text()();

  BoolColumn get isDefault => boolean()();

  BoolColumn get shared => boolean()();

  BoolColumn get sharedToAll => boolean()();

  IntColumn get sharedToAllAccess => integer()();

  IntColumn get access => integer()();

  // TODO shares one to many

  BoolColumn get isPublic => boolean()();

  BoolColumn get isSubscribed => boolean()();

  TextColumn get syncToken => text()();
}

