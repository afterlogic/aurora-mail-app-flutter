import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:drift/drift.dart';

@DataClassName("CalendarDb")
class CalendarTable extends Table{

  @override
  Set<Column> get primaryKey => {id, userLocalId};

  TextColumn get id => text()();

  TextColumn get url => text()();

  TextColumn get serverUrl => text()();

  TextColumn get exportHash => text()();

  TextColumn get pubHash => text()();

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

  TextColumn get shares => text().map(const ListStringConverter()).nullable()();

  BoolColumn get isPublic => boolean()();

  BoolColumn get isSubscribed => boolean()();

  TextColumn get source => text()();

  TextColumn get syncToken => text()();
}

