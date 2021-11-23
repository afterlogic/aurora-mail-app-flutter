import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';

class ContactMapper {
  static Contact fromDB(ContactDb contact) {
    if (contact == null) {
      return null;
    }
    return Contact(
      entityId: contact.entityId,
      userLocalId: contact.userLocalId,
      uuidPlusStorage: contact.uuidPlusStorage,
      uuid: contact.uuid,
      parentUuid: contact.parentUuid,
      idUser: contact.idUser,
      idTenant: contact.idTenant,
      storage: contact.storage,
      fullName: contact.fullName,
      useFriendlyName: contact.useFriendlyName,
      primaryEmail: contact.primaryEmail,
      primaryPhone: contact.primaryPhone,
      primaryAddress: contact.primaryAddress,
      viewEmail: contact.viewEmail,
      title: contact.title,
      firstName: contact.firstName,
      lastName: contact.lastName,
      nickName: contact.nickName,
      skype: contact.skype,
      facebook: contact.facebook,
      personalEmail: contact.personalEmail,
      personalAddress: contact.personalAddress,
      personalCity: contact.personalCity,
      personalState: contact.personalState,
      personalZip: contact.personalZip,
      personalCountry: contact.personalCountry,
      personalWeb: contact.personalWeb,
      personalFax: contact.personalFax,
      personalPhone: contact.personalPhone,
      personalMobile: contact.personalMobile,
      businessEmail: contact.businessEmail,
      businessCompany: contact.businessCompany,
      businessAddress: contact.businessAddress,
      businessCity: contact.businessCity,
      businessState: contact.businessState,
      businessZip: contact.businessZip,
      businessCountry: contact.businessCountry,
      businessJobTitle: contact.businessJobTitle,
      businessDepartment: contact.businessDepartment,
      businessOffice: contact.businessOffice,
      businessPhone: contact.businessPhone,
      businessFax: contact.businessFax,
      businessWeb: contact.businessWeb,
      otherEmail: contact.otherEmail,
      notes: contact.notes,
      birthDay: contact.birthDay,
      birthMonth: contact.birthMonth,
      birthYear: contact.birthYear,
      eTag: contact.eTag,
      auto: contact.auto,
      frequency: contact.frequency,
      dateModified: contact.dateModified,
      davContactsUid: contact.davContactsUid,
      davContactsVCardUid: contact.davContactsVCardUid,
      groupUUIDs: contact.groupUUIDs,
      pgpPublicKey: contact.pgpPublicKey,
      autoEncrypt: contact.autoEncrypt,
      autoSign: contact.autoSign,
    );
  }

  static List<Contact> listFromDB(List<ContactDb> dbEntries) {
    return dbEntries.map((e) {
      return fromDB(e);
    }).toList();
  }

  static List<ContactDb> toDB(List<Contact> contacts) {
    return contacts.map((e) {
      return new ContactDb(
        entityId: e.entityId,
        uuid: e.uuid,
        userLocalId: e.userLocalId,
        uuidPlusStorage: e.uuidPlusStorage,
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
        pgpPublicKey: e.pgpPublicKey,
        autoEncrypt: e.autoEncrypt,
        autoSign: e.autoSign,
      );
    }).toList();
  }

  static List<Contact> fromNetwork(List<dynamic> rawItems, int userLocalId) {
    final result = <Contact>[];
    rawItems.forEach((i) {
      final pgpPublicKey = i["PublicPgpKey"] ?? i["OpenPgpWebclient::PgpKey"];
      if (pgpPublicKey != null) {
        print(pgpPublicKey);
      }
      try {
        final contact = Contact(
          entityId: i["EntityId"] as int,
          userLocalId: userLocalId,
          uuid: i["UUID"] as String,
          uuidPlusStorage: i["UUID"] + i["Storage"] as String,
          parentUuid: i["ParentUUID"] as String ?? '',
          idUser: i["IdUser"] as int,
          idTenant: i["IdTenant"] as int,
          storage: i["Storage"] as String,
          fullName: i["FullName"] as String,
          useFriendlyName: i["UseFriendlyName"] as bool,
          primaryEmail: i["PrimaryEmail"] as int ?? 0,
          primaryPhone: i["PrimaryPhone"] as int ?? 0,
          primaryAddress: i["PrimaryAddress"] as int ?? 0,
          viewEmail: i["ViewEmail"] as String,
          title: i["Title"] as String ?? '',
          firstName: i["FirstName"] as String ?? '',
          lastName: i["LastName"] as String ?? '',
          nickName: i["NickName"] as String ?? '',
          skype: i["Skype"] as String ?? '',
          facebook: i["Facebook"] as String ?? '',
          personalEmail: i["PersonalEmail"] as String ?? '',
          personalAddress: i["PersonalAddress"] as String ?? '',
          personalCity: i["PersonalCity"] as String ?? '',
          personalState: i["PersonalState"] as String ?? '',
          personalZip: i["PersonalZip"] as String ?? '',
          personalCountry: i["PersonalCountry"] as String ?? '',
          personalWeb: i["PersonalWeb"] as String ?? '',
          personalFax: i["PersonalFax"] as String ?? '',
          personalPhone: i["PersonalPhone"] as String ?? '',
          personalMobile: i["PersonalMobile"] as String ?? '',
          businessEmail: i["BusinessEmail"] as String ?? '',
          businessCompany: i["BusinessCompany"] as String ?? '',
          businessAddress: i["BusinessAddress"] as String ?? '',
          businessCity: i["BusinessCity"] as String ?? '',
          businessState: i["BusinessState"] as String ?? '',
          businessZip: i["BusinessZip"] as String ?? '',
          businessCountry: i["BusinessCountry"] as String ?? '',
          businessJobTitle: i["BusinessJobTitle"] as String ?? '',
          businessDepartment: i["BusinessDepartment"] as String ?? '',
          businessOffice: i["BusinessOffice"] as String ?? '',
          businessPhone: i["BusinessPhone"] as String ?? '',
          businessFax: i["BusinessFax"] as String ?? '',
          businessWeb: i["BusinessWeb"] as String ?? '',
          otherEmail: i["OtherEmail"] as String ?? '',
          notes: i["Notes"] as String ?? '',
          birthDay: i["BirthDay"] as int ?? 0,
          birthMonth: i["BirthMonth"] as int ?? 0,
          birthYear: i["BirthYear"] as int ?? 0,
          eTag: i["ETag"] as String,
          auto: i["Auto"] as bool ?? false,
          frequency: i["Frequency"] as int,
          dateModified: i["DateModified"] as String,
          davContactsUid: i["DavContacts::UID"] as String,
          davContactsVCardUid: i["DavContacts::VCardUID"] as String,
          groupUUIDs: new List<String>.from(i["GroupUUIDs"] as List),
          pgpPublicKey: pgpPublicKey as String,
          autoSign: i["OpenPgpWebclient::PgpSignMessages"] as bool,
          autoEncrypt: i["OpenPgpWebclient::PgpEncryptMessages"] as bool,
        );
        result.add(contact);
      } catch (err) {
        print('ERROR ContactMapper.fromNetwork: $err');
        // rethrow;
      }
    });
    return result;
  }

  static Map<String, dynamic> toNetwork(Contact c) {
    return {
      "UUID": c.uuid ?? '',
      "Storage": c.storage ?? '',
      "FullName": c.fullName ?? '',
      "UseFriendlyName": c.useFriendlyName ?? false,
      "PrimaryEmail": c.primaryEmail ?? 0,
      "PrimaryPhone": c.primaryPhone ?? 0,
      "PrimaryAddress": c.primaryAddress ?? 0,
      "FirstName": c.firstName ?? '',
      "LastName": c.lastName ?? '',
      "NickName": c.nickName ?? '',
      "Skype": c.skype ?? '',
      "Facebook": c.facebook ?? '',
      "PersonalEmail": c.personalEmail ?? '',
      "PersonalAddress": c.personalAddress ?? '',
      "PersonalCity": c.personalCity ?? '',
      "PersonalState": c.personalState ?? '',
      "PersonalZip": c.personalZip ?? '',
      "PersonalCountry": c.personalCountry ?? '',
      "PersonalWeb": c.personalWeb ?? '',
      "PersonalFax": c.personalFax ?? '',
      "PersonalPhone": c.personalPhone ?? '',
      "PersonalMobile": c.personalMobile ?? '',
      "BusinessEmail": c.businessEmail ?? '',
      "BusinessCompany": c.businessCompany ?? '',
      "BusinessAddress": c.businessAddress ?? '',
      "BusinessCity": c.businessCity ?? '',
      "BusinessState": c.businessState ?? '',
      "BusinessZip": c.businessZip ?? '',
      "BusinessCountry": c.businessCountry ?? '',
      "BusinessJobTitle": c.businessJobTitle ?? '',
      "BusinessDepartment": c.businessDepartment ?? '',
      "BusinessOffice": c.businessOffice ?? '',
      "BusinessPhone": c.businessPhone ?? '',
      "BusinessFax": c.businessFax ?? '',
      "BusinessWeb": c.businessWeb ?? '',
      "OtherEmail": c.otherEmail ?? '',
      "Notes": c.notes ?? '',
      "BirthDay": c.birthDay ?? 0,
      "BirthMonth": c.birthMonth ?? 0,
      "BirthYear": c.birthYear ?? 0,
      "ETag": c.eTag ?? '',
      "GroupUUIDs": c.groupUUIDs ?? [],
      "OpenPgpWebclient::PublicPgpKey": c.pgpPublicKey ?? '',
      "OpenPgpWebclient::PgpSignMessages": c.autoSign ?? false,
      "OpenPgpWebclient::PgpEncryptMessages": c.autoEncrypt ?? false,
    };
  }
}
