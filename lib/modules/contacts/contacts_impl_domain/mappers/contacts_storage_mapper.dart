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

  static List<ContactsStoragesTable> toDB(
      List<ContactsStorage> items, int userId) {
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

  static List<ContactsStorage> allFromNetwork(List rawItems) {
    return rawItems.map((i) {
      final item = Map<String, dynamic>.from(i as Map);
      return fromNetwork(item);
    }).toList();
  }

  static ContactsStorage fromNetwork(Map<String, dynamic> rawItems) {
    return ContactsStorage(
      sqliteId: null,
      id: rawItems["Id"] as String,
      name: rawItems["Name"] as String ?? rawItems["Id"] as String,
      cTag: rawItems["CTag"] as int,
      display: rawItems["Display"] as bool ?? true,
      contactsInfo: null,
    );
  }
}