import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactsStorageMapper {
  static List<ContactsStorage> fromDB(List<ContactsStoragesTable> items) {
    return items.map((i) {
      return new ContactsStorage(
        sqliteId: i.sqliteId,
        id: i.serverId,
        name: i.name,
        cTag: i.cTag,
        display: i.display,
        contactsInfo: i.contactsInfo,
      );
    }).toList();
  }

  static List<ContactsStoragesTable> toDB(List<ContactsStorage> items,
      int userId) {
    return items.map((i) {
      return new ContactsStoragesTable(
        sqliteId: i.sqliteId,
        idUser: userId,
        serverId: i.id,
        name: i.name,
        cTag: i.cTag,
        display: i.display,
        contactsInfo: i.contactsInfo,
      );
    }).toList();
  }

  static List<ContactsStorage> fromNetwork(
      List<Map<String, dynamic>> rawItems) {
    return rawItems.map((i) {
      return new ContactsStorage(
        sqliteId: null,
        id: i["Id"],
        name: i["Name"],
        cTag: i["CTag"],
        display: i["Display"] ?? true,
        contactsInfo: null,
      );
    }).toList();
  }
}
