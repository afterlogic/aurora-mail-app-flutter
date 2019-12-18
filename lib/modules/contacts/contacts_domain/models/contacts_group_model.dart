import 'package:flutter/widgets.dart';

class ContactsGroup {
  final String uuid;
  final int idUser;
  final int entityId;
  final String city;
  final String company;
  final String country;
  final String davContactsUID;
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
    @required this.idUser,
    @required this.uuid,
    @required this.name,
    this.city = "",
    this.company = "",
    this.country = "",
    this.davContactsUID,
    this.email = "",
    this.entityId,
    this.fax = "",
    this.isOrganization,
    this.parentUUID = "",
    this.phone = "",
    this.state = "",
    this.street = "",
    this.web = "",
    this.zip = "",
  });
}
