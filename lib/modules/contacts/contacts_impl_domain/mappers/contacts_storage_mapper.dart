import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';

class ContactsStorageMapper {
  static List<ContactsStorage> fromDB(List<ContactsStoragesTable> items) {
    return items.map((i) {
      return new ContactsStorage(
        sqliteId: i.sqliteId,
        id: i.serverId,
        userLocalId: i.userLocalId,
        name: i.name,
        uniqueName: i.uniqueName,
        cTag: i.cTag,
        display: i.display,
        displayName: i.displayName,
        contactsInfo: i.contactsInfo,
      );
    }).toList();
  }

  static List<ContactsStoragesTable> toDB(
      List<ContactsStorage> items, int userId) {
    return items.map((i) {
      return new ContactsStoragesTable(
        sqliteId: i.sqliteId,
        userLocalId: i.userLocalId,
        idUser: userId,
        serverId: i.id,
        uniqueName: i.uniqueName,
        name: i.name,
        cTag: i.cTag,
        display: i.display,
        displayName: i.displayName,
        contactsInfo: i.contactsInfo,
      );
    }).toList();
  }

  static List<ContactsStorage> allFromNetwork(List rawItems, int userLocalId) {
    return rawItems.map((i) {
      final item = Map<String, dynamic>.from(i as Map);
      return fromNetwork(item, userLocalId);
    }).toList();
  }

  static ContactsStorage fromNetwork(
      Map<String, dynamic> rawItems, int userLocalId) {
    return ContactsStorage(
      sqliteId: null,
      id: rawItems["Id"] as String,
      uniqueName: rawItems["Id"].toString() + userLocalId.toString(),
      userLocalId: userLocalId,
      name: rawItems["Name"] as String ?? rawItems["Id"] as String,
      cTag: rawItems["CTag"] as int,
      display: rawItems["Display"] as bool ?? true,
      displayName: rawItems["DisplayName"] as String,
      contactsInfo: null,
    );
  }
}
