import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("ContactsTable")
class Contacts extends Table {
  Set<Column> get primaryKey => {entityId};

  // deprecated
  TextColumn get uuidPlusStorage => text()();

  TextColumn get uuid => text()();

  IntColumn get userLocalId => integer()();

  IntColumn get entityId => integer().nullable()();

  TextColumn get parentUuid => text().nullable()();

  TextColumn get eTag => text()();

  IntColumn get idUser => integer()();

  IntColumn get idTenant => integer().nullable()();

  TextColumn get storage => text()();

  TextColumn get fullName => text()();

  BoolColumn get useFriendlyName => boolean().nullable()();

  IntColumn get primaryEmail => integer()();

  IntColumn get primaryPhone => integer()();

  IntColumn get primaryAddress => integer()();

  TextColumn get viewEmail => text()();

  TextColumn get title => text()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  TextColumn get nickName => text()();

  TextColumn get skype => text()();

  TextColumn get facebook => text()();

  TextColumn get personalEmail => text()();

  TextColumn get personalAddress => text()();

  TextColumn get personalCity => text()();

  TextColumn get personalState => text()();

  TextColumn get personalZip => text()();

  TextColumn get personalCountry => text()();

  TextColumn get personalWeb => text()();

  TextColumn get personalFax => text()();

  TextColumn get personalPhone => text()();

  TextColumn get personalMobile => text()();

  TextColumn get businessEmail => text()();

  TextColumn get businessCompany => text()();

  TextColumn get businessAddress => text()();

  TextColumn get businessCity => text()();

  TextColumn get businessState => text()();

  TextColumn get businessZip => text()();

  TextColumn get businessCountry => text()();

  TextColumn get businessJobTitle => text()();

  TextColumn get businessDepartment => text()();

  TextColumn get businessOffice => text()();

  TextColumn get businessPhone => text()();

  TextColumn get businessFax => text()();

  TextColumn get businessWeb => text()();

  TextColumn get otherEmail => text()();

  TextColumn get notes => text()();

  IntColumn get birthDay => integer()();

  IntColumn get birthMonth => integer()();

  IntColumn get birthYear => integer()();

  BoolColumn get auto => boolean().nullable()();

  IntColumn get frequency => integer().withDefault(Constant(0))();

  TextColumn get dateModified => text().nullable()();

  TextColumn get davContactsUid => text().nullable()();

  TextColumn get davContactsVCardUid => text().nullable()();

  TextColumn get groupUUIDs => text().map(const ListStringConverter())();
}
