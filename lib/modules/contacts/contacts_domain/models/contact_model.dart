import 'package:flutter/widgets.dart';

class Contact {
  final int entityId;
  final String uuid;
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

  const Contact({
    @required this.entityId,
    @required this.uuid,
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
}
