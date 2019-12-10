import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

class ContactsGroupMapper {
  static List<ContactsGroupsTable> toDB(List<ContactsGroup> items) {
    return items.map((i) {
      return new ContactsGroupsTable(
        uuid: i.uuid,
        idUser: i.idUser,
        entityId: i.entityId,
        city: i.city,
        company: i.company,
        country: i.country,
        davContactsUID: i.davContactsUID,
        email: i.email,
        events: i.events,
        fax: i.fax,
        isOrganization: i.isOrganization,
        name: i.name,
        parentUUID: i.parentUUID,
        phone: i.phone,
        state: i.state,
        street: i.street,
        web: i.web,
        zip: i.zip,
      );
    });
  }
  static List<ContactsGroup> fromDB(List<ContactsGroupsTable> dbItems) {
    return dbItems.map((i) {
      return new ContactsGroup(
        uuid: i.uuid,
        idUser: i.idUser,
        entityId: i.entityId,
        city: i.city,
        company: i.company,
        country: i.country,
        davContactsUID: i.davContactsUID,
        email: i.email,
        events: i.events,
        fax: i.fax,
        isOrganization: i.isOrganization,
        name: i.name,
        parentUUID: i.parentUUID,
        phone: i.phone,
        state: i.state,
        street: i.street,
        web: i.web,
        zip: i.zip,
      );
    });
  }
  static List<ContactsGroup> fromNetwork(List<Map<String, dynamic>> rawItems) {
    return rawItems.map((i) {
      return new ContactsGroup(
        uuid: i["UUID"],
        idUser: i["IdUser"],
        entityId: i["EntityId"],
        city: i["City"],
        company: i["Company"],
        country: i["Country"],
        davContactsUID: i["DavContacts::UID"],
        email: i["Email"],
        events: i["Events"],
        fax: i["Fax"],
        isOrganization: i["IsOrganization"],
        name: i["Name"],
        parentUUID: i["ParentUUID"],
        phone: i["Phone"],
        state: i["State"],
        street: i["Street"],
        web: i["Web"],
        zip: i["Zip"],
      );
    });
  }
}
