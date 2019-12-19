import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';

class ContactsGroupMapper {
  static List<ContactsGroupsTable> toDB(List<ContactsGroup> items) {
    return items.map((i) {
      return new ContactsGroupsTable(
        uuid: i.uuid,
        idUser: i.idUser,
        city: i.city,
        company: i.company,
        country: i.country,
        email: i.email,
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
    }).toList();
  }

  static List<ContactsGroup> fromDB(List<ContactsGroupsTable> dbItems) {
    return dbItems.map((i) {
      return new ContactsGroup(
        uuid: i.uuid,
        idUser: i.idUser,
        city: i.city,
        company: i.company,
        country: i.country,
        email: i.email,
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
    }).toList();
  }

  static List<ContactsGroup> allFromNetwork(List rawItems) {
    return rawItems.map((i) {
      final item = Map<String, dynamic>.from(i as Map);
      return fromNetwork(item);
    }).toList();
  }

  static ContactsGroup fromNetwork(Map<String, dynamic> i) {
    return ContactsGroup(
      uuid: i["UUID"] as String,
      idUser: i["IdUser"] as int,
      city: i["City"] as String,
      company: i["Company"] as String,
      country: i["Country"] as String,
      email: i["Email"] as String,
      fax: i["Fax"] as String,
      isOrganization: i["IsOrganization"] as bool,
      name: i["Name"] as String,
      parentUUID: i["ParentUUID"] as String,
      phone: i["Phone"] as String,
      state: i["State"] as String,
      street: i["Street"] as String,
      web: i["Web"] as String,
      zip: i["Zip"] as String,
    );
  }

  static Map<String, dynamic> toNetwork(ContactsGroup group) {
    return {
      "UUID": group.uuid,
      "IdUser": group.idUser,
      "City": group.city,
      "Company": group.company,
      "Country": group.country,
      "Email": group.email,
      "Fax": group.fax,
      "IsOrganization": group.isOrganization,
      "Name": group.name,
      "ParentUUID": group.parentUUID,
      "Phone": group.phone,
      "State": group.state,
      "Street": group.street,
      "Web": group.web,
      "Zip": group.zip,
    };
  }
}
