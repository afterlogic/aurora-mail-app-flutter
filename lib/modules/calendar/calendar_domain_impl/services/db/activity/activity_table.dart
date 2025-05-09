import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/activity.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/every_week_frequency.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/update_status.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:drift/drift.dart';

@DataClassName("ActivityDb")
class ActivityTable extends Table {

  @override
  Set<Column> get primaryKey => {uid, userLocalId, calendarId};

  IntColumn get type => intEnum<ActivityType>().nullable()();

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

  TextColumn get remindersString => text().nullable()();

  BoolColumn get status => boolean().nullable()();

  BoolColumn get withDate => boolean().nullable()();

  BoolColumn get isPrivate => boolean().nullable()();

  IntColumn get updateStatus => intEnum<UpdateStatus>()();

  BoolColumn get synced =>  boolean()();

  BoolColumn get onceLoaded =>  boolean()();

  IntColumn get recurrenceMode => intEnum<RecurrenceMode>().nullable()();

  IntColumn get recurrenceWeeklyFrequency => intEnum<EveryWeekFrequency>().nullable()();

  DateTimeColumn get recurrenceUntilDate => dateTime().nullable()();

  TextColumn get recurrenceWeekDaysString => text().nullable()();

  TextColumn get attendees => text().map(const ListStringConverter()).nullable()();
}
