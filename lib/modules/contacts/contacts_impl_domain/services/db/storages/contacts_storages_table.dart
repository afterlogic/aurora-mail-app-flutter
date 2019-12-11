import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/converters/contacts_info_converter.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("ContactsStoragesTable")
class ContactsStorages extends Table {
  IntColumn get sqliteId => integer().autoIncrement()();

  IntColumn get idUser => integer()();

  TextColumn get serverId => text()();

  TextColumn get name => text()();

  IntColumn get cTag => integer()();

  BoolColumn get display => boolean()();

  TextColumn get contactsInfo => text().map(const ContactsInfoConverter())();
}
