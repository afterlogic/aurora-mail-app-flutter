import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

class ContactsGroupMapper {
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
