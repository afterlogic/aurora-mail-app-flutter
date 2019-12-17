import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

class ContactMapper {
  static List<Contact> fromDB(List<ContactsTable> dbEntries) {
    return dbEntries.map((e) {
      return new Contact(
        entityId: e.entityId,
        uuid: e.uuid,
        parentUuid: e.parentUuid,
        idUser: e.idUser,
        idTenant: e.idTenant,
        storage: e.storage,
        fullName: e.fullName,
        useFriendlyName: e.useFriendlyName,
        primaryEmail: e.primaryEmail,
        primaryPhone: e.primaryPhone,
        primaryAddress: e.primaryAddress,
        viewEmail: e.viewEmail,
        title: e.title,
        firstName: e.firstName,
        lastName: e.lastName,
        nickName: e.nickName,
        skype: e.skype,
        facebook: e.facebook,
        personalEmail: e.personalEmail,
        personalAddress: e.personalAddress,
        personalCity: e.personalCity,
        personalState: e.personalState,
        personalZip: e.personalZip,
        personalCountry: e.personalCountry,
        personalWeb: e.personalWeb,
        personalFax: e.personalFax,
        personalPhone: e.personalPhone,
        personalMobile: e.personalMobile,
        businessEmail: e.businessEmail,
        businessCompany: e.businessCompany,
        businessAddress: e.businessAddress,
        businessCity: e.businessCity,
        businessState: e.businessState,
        businessZip: e.businessZip,
        businessCountry: e.businessCountry,
        businessJobTitle: e.businessJobTitle,
        businessDepartment: e.businessDepartment,
        businessOffice: e.businessOffice,
        businessPhone: e.businessPhone,
        businessFax: e.businessFax,
        businessWeb: e.businessWeb,
        otherEmail: e.otherEmail,
        notes: e.notes,
        birthDay: e.birthDay,
        birthMonth: e.birthMonth,
        birthYear: e.birthYear,
        eTag: e.eTag,
        auto: e.auto,
        frequency: e.frequency,
        dateModified: e.dateModified,
        davContactsUid: e.davContactsUid,
        davContactsVCardUid: e.davContactsVCardUid,
        groupUUIDs: e.groupUUIDs,
      );
    }).toList();
  }

  static List<ContactsTable> toDB(List<Contact> contacts) {
    return contacts.map((e) {
      return new ContactsTable(
        entityId: e.entityId,
        uuid: e.uuid,
        parentUuid: e.parentUuid,
        idUser: e.idUser,
        idTenant: e.idTenant,
        storage: e.storage,
        fullName: e.fullName,
        useFriendlyName: e.useFriendlyName,
        primaryEmail: e.primaryEmail,
        primaryPhone: e.primaryPhone,
        primaryAddress: e.primaryAddress,
        viewEmail: e.viewEmail,
        title: e.title,
        firstName: e.firstName,
        lastName: e.lastName,
        nickName: e.nickName,
        skype: e.skype,
        facebook: e.facebook,
        personalEmail: e.personalEmail,
        personalAddress: e.personalAddress,
        personalCity: e.personalCity,
        personalState: e.personalState,
        personalZip: e.personalZip,
        personalCountry: e.personalCountry,
        personalWeb: e.personalWeb,
        personalFax: e.personalFax,
        personalPhone: e.personalPhone,
        personalMobile: e.personalMobile,
        businessEmail: e.businessEmail,
        businessCompany: e.businessCompany,
        businessAddress: e.businessAddress,
        businessCity: e.businessCity,
        businessState: e.businessState,
        businessZip: e.businessZip,
        businessCountry: e.businessCountry,
        businessJobTitle: e.businessJobTitle,
        businessDepartment: e.businessDepartment,
        businessOffice: e.businessOffice,
        businessPhone: e.businessPhone,
        businessFax: e.businessFax,
        businessWeb: e.businessWeb,
        otherEmail: e.otherEmail,
        notes: e.notes,
        birthDay: e.birthDay,
        birthMonth: e.birthMonth,
        birthYear: e.birthYear,
        eTag: e.eTag,
        auto: e.auto,
        frequency: e.frequency,
        dateModified: e.dateModified,
        davContactsUid: e.davContactsUid,
        davContactsVCardUid: e.davContactsVCardUid,
        groupUUIDs: e.groupUUIDs,
      );
    }).toList();
  }

  static List<Contact> fromNetwork(List<dynamic> rawItems) {
    return rawItems.map((i) {
      return new Contact(
        entityId: i["EntityId"],
        uuid: i["UUID"],
        parentUuid: i["ParentUUID"],
        idUser: i["IdUser"],
        idTenant: i["IdTenant"],
        storage: i["Storage"],
        fullName: i["FullName"],
        useFriendlyName: i["UseFriendlyName"],
        primaryEmail: i["PrimaryEmail"],
        primaryPhone: i["PrimaryPhone"],
        primaryAddress: i["PrimaryAddress"],
        viewEmail: i["ViewEmail"],
        title: i["Title"],
        firstName: i["FirstName"],
        lastName: i["LastName"],
        nickName: i["NickName"],
        skype: i["Skype"],
        facebook: i["Facebook"],
        personalEmail: i["PersonalEmail"],
        personalAddress: i["PersonalAddress"],
        personalCity: i["PersonalCity"],
        personalState: i["PersonalState"],
        personalZip: i["PersonalZip"],
        personalCountry: i["PersonalCountry"],
        personalWeb: i["PersonalWeb"],
        personalFax: i["PersonalFax"],
        personalPhone: i["PersonalPhone"],
        personalMobile: i["PersonalMobile"],
        businessEmail: i["BusinessEmail"],
        businessCompany: i["BusinessCompany"],
        businessAddress: i["BusinessAddress"],
        businessCity: i["BusinessCity"],
        businessState: i["BusinessState"],
        businessZip: i["BusinessZip"],
        businessCountry: i["BusinessCountry"],
        businessJobTitle: i["BusinessJobTitle"],
        businessDepartment: i["BusinessDepartment"],
        businessOffice: i["BusinessOffice"],
        businessPhone: i["BusinessPhone"],
        businessFax: i["BusinessFax"],
        businessWeb: i["BusinessWeb"],
        otherEmail: i["OtherEmail"],
        notes: i["Notes"],
        birthDay: i["BirthDay"],
        birthMonth: i["BirthMonth"],
        birthYear: i["BirthYear"],
        eTag: i["ETag"],
        auto: i["Auto"],
        frequency: i["Frequency"],
        dateModified: i["DateModified"],
        davContactsUid: i["DavContacts::UID"],
        davContactsVCardUid: i["DavContacts::VCardUID"],
        groupUUIDs: new List<String>.from(i["GroupUUIDs"]),
      );
    }).toList();
  }
}
