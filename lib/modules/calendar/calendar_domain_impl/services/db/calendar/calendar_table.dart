import 'package:drift/drift.dart';

@DataClassName("CalendarDb")
class CalendarTable extends Table{

  @override
  Set<Column> get primaryKey => {uuid};

  TextColumn get uuid => text()();

  TextColumn get color => text()();

  TextColumn get description => text().nullable()();

  TextColumn get name => text()();

  IntColumn get userLocalId => integer()();

}

