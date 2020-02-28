import 'package:flutter/widgets.dart';

class Contact {
  final int entityId;
  final int userLocalId;
  final String uuid;
  final String uuidPlusStorage;
  final String parentUuid;
  final int idUser;
  final int idTenant;
  final String storage;
  final String fullName;
  final bool useFriendlyName;
  final int primaryEmail;
  final int primaryPhone;
  final int primaryAddress;
  final String viewEmail;
  final String title;
  final String firstName;
  final String lastName;
  final String nickName;
  final String skype;
  final String facebook;
  final String personalEmail;
  final String personalAddress;
  final String personalCity;
  final String personalState;
  final String personalZip;
  final String personalCountry;
  final String personalWeb;
  final String personalFax;
  final String personalPhone;
  final String personalMobile;
  final String businessEmail;
  final String businessCompany;
  final String businessAddress;
  final String businessCity;
  final String businessState;
  final String businessZip;
  final String businessCountry;
  final String businessJobTitle;
  final String businessDepartment;
  final String businessOffice;
  final String businessPhone;
  final String businessFax;
  final String businessWeb;
  final String otherEmail;
  final String notes;
  final int birthDay;
  final int birthMonth;
  final int birthYear;
  final String eTag;
  final bool auto;
  final int frequency;
  final String dateModified;
  final String davContactsUid;
  final String davContactsVCardUid;
  final List<String> groupUUIDs;

  int get ageScore {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final modified = DateTime.parse(dateModified);
    final difference = tomorrow.difference(modified).inDays;
    return (frequency / (difference / 30)).ceil();
  }

  const Contact({
    @required this.entityId,
    @required this.uuid,
    @required this.userLocalId,
    @required this.uuidPlusStorage,
    this.parentUuid = "",
    @required this.idUser,
    @required this.idTenant,
    @required this.storage,
    @required this.fullName,
    @required this.useFriendlyName,
    this.primaryEmail = 0,
    this.primaryPhone = 0,
    this.primaryAddress = 0,
    @required this.viewEmail,
    this.title = "",
    this.firstName = "",
    this.lastName = "",
    this.nickName = "",
    this.skype = "",
    this.facebook = "",
    this.personalEmail,
    this.personalAddress = "",
    this.personalCity = "",
    this.personalState = "",
    this.personalZip = "",
    this.personalCountry = "",
    this.personalWeb = "",
    this.personalFax = "",
    this.personalPhone = "",
    this.personalMobile = "",
    this.businessEmail = "",
    this.businessCompany = "",
    this.businessAddress = "",
    this.businessCity = "",
    this.businessState = "",
    this.businessZip = "",
    this.businessCountry = "",
    this.businessJobTitle = "",
    this.businessDepartment = "",
    this.businessOffice = "",
    this.businessPhone = "",
    this.businessFax = "",
    this.businessWeb = "",
    this.otherEmail = "",
    this.notes = "",
    this.birthDay = 0,
    this.birthMonth = 0,
    this.birthYear = 0,
    @required this.eTag,
    this.auto = false,
    @required this.frequency,
    @required this.dateModified,
    @required this.davContactsUid,
    @required this.davContactsVCardUid,
    @required this.groupUUIDs,
  });

  Contact copyWith({
    int localId,
    int entityId,
    String uuid,
    int userLocalId,
    String uuidPlusStorage,
    String parentUuid,
    int idUser,
    int idTenant,
    String storage,
    String fullName,
    bool useFriendlyName,
    int primaryEmail,
    int primaryPhone,
    int primaryAddress,
    String viewEmail,
    String title,
    String firstName,
    String lastName,
    String nickName,
    String skype,
    String facebook,
    String personalEmail,
    String personalAddress,
    String personalCity,
    String personalState,
    String personalZip,
    String personalCountry,
    String personalWeb,
    String personalFax,
    String personalPhone,
    String personalMobile,
    String businessEmail,
    String businessCompany,
    String businessAddress,
    String businessCity,
    String businessState,
    String businessZip,
    String businessCountry,
    String businessJobTitle,
    String businessDepartment,
    String businessOffice,
    String businessPhone,
    String businessFax,
    String businessWeb,
    String otherEmail,
    String notes,
    int birthDay,
    int birthMonth,
    int birthYear,
    String eTag,
    bool auto,
    int frequency,
    String dateModified,
    String davContactsUid,
    String davContactsVCardUid,
    List<String> groupUUIDs,
  }) {
    return new Contact(
      entityId: entityId ?? this.entityId,
      userLocalId: userLocalId ?? this.userLocalId,
      uuid: uuid ?? this.uuid,
      uuidPlusStorage: uuidPlusStorage ?? this.uuidPlusStorage,
      parentUuid: parentUuid ?? this.parentUuid,
      idUser: idUser ?? this.idUser,
      idTenant: idTenant ?? this.idTenant,
      storage: storage ?? this.storage,
      fullName: fullName ?? this.fullName,
      useFriendlyName: useFriendlyName ?? this.useFriendlyName,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      viewEmail: viewEmail ?? this.viewEmail,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickName: nickName ?? this.nickName,
      skype: skype ?? this.skype,
      facebook: facebook ?? this.facebook,
      personalEmail: personalEmail ?? this.personalEmail,
      personalAddress: personalAddress ?? this.personalAddress,
      personalCity: personalCity ?? this.personalCity,
      personalState: personalState ?? this.personalState,
      personalZip: personalZip ?? this.personalZip,
      personalCountry: personalCountry ?? this.personalCountry,
      personalWeb: personalWeb ?? this.personalWeb,
      personalFax: personalFax ?? this.personalFax,
      personalPhone: personalPhone ?? this.personalPhone,
      personalMobile: personalMobile ?? this.personalMobile,
      businessEmail: businessEmail ?? this.businessEmail,
      businessCompany: businessCompany ?? this.businessCompany,
      businessAddress: businessAddress ?? this.businessAddress,
      businessCity: businessCity ?? this.businessCity,
      businessState: businessState ?? this.businessState,
      businessZip: businessZip ?? this.businessZip,
      businessCountry: businessCountry ?? this.businessCountry,
      businessJobTitle: businessJobTitle ?? this.businessJobTitle,
      businessDepartment: businessDepartment ?? this.businessDepartment,
      businessOffice: businessOffice ?? this.businessOffice,
      businessPhone: businessPhone ?? this.businessPhone,
      businessFax: businessFax ?? this.businessFax,
      businessWeb: businessWeb ?? this.businessWeb,
      otherEmail: otherEmail ?? this.otherEmail,
      notes: notes ?? this.notes,
      birthDay: birthDay ?? this.birthDay,
      birthMonth: birthMonth ?? this.birthMonth,
      birthYear: birthYear ?? this.birthYear,
      eTag: eTag ?? this.eTag,
      auto: auto ?? this.auto,
      frequency: frequency ?? this.frequency,
      dateModified: dateModified ?? this.dateModified,
      davContactsUid: davContactsUid ?? this.davContactsUid,
      davContactsVCardUid: davContactsVCardUid ?? this.davContactsVCardUid,
      groupUUIDs: groupUUIDs ?? this.groupUUIDs,
    );
  }
}
