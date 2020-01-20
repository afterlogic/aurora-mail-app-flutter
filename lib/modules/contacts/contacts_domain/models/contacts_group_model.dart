import 'package:flutter/widgets.dart';

class ContactsGroup {
  final String uuid;
  final int userLocalId;
  final int idUser;
  final String city;
  final String company;
  final String country;
  final String email;
  final String fax;
  final bool isOrganization;
  final String name;
  final String parentUUID;
  final String phone;
  final String state;
  final String street;
  final String web;
  final String zip;

  ContactsGroup({
    @required this.uuid,
    @required this.userLocalId,
    @required this.idUser,
    @required this.name,
    this.city = "",
    this.company = "",
    this.country = "",
    this.email = "",
    this.fax = "",
    this.isOrganization,
    this.parentUUID = "",
    this.phone = "",
    this.state = "",
    this.street = "",
    this.web = "",
    this.zip = "",
  });

  ContactsGroup copyWith({
    String uuid,
    int userLocalId,
    int idUser,
    String city,
    String company,
    String country,
    String davContactsUID,
    String email,
    String fax,
    bool isOrganization,
    String name,
    String parentUUID,
    String phone,
    String state,
    String street,
    String web,
    String zip,
  }) {
    return new ContactsGroup(
      uuid: uuid ?? this.uuid,
      userLocalId: userLocalId ?? this.userLocalId,
      idUser: idUser ?? this.idUser,
      city: city ?? this.city,
      company: company ?? this.company,
      country: country ?? this.country,
      email: email ?? this.email,
      fax: fax ?? this.fax,
      isOrganization: isOrganization ?? this.isOrganization,
      name: name ?? this.name,
      parentUUID: parentUUID ?? this.parentUUID,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      street: street ?? this.street,
      web: web ?? this.web,
      zip: zip ?? this.zip,
    );
  }

}
