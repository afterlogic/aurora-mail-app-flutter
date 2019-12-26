import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_info_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_group_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_storage_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsNetworkServiceImpl implements ContactsNetworkService {
  final WebMailApi contactsModule;

  ContactsNetworkServiceImpl(this.contactsModule);

  @override
  Future<List<ContactsStorage>> getContactStorages() async {
    final body = new WebMailApiBody(
      method: "GetContactStorages",
      parameters: null,
    );

    final result = await contactsModule.post(body) as List;
    return ContactsStorageMapper.allFromNetwork(result);
  }

  @override
  Future<List<Contact>> getContactsByUids(ContactsStorage storage, List<String> uids) async {
    final params = {
      "Storage": storage.id,
      "Uids": uids,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    return ContactMapper.fromNetwork(result as List);
  }

  @override
  Future<List<ContactInfoItem>> getContactsInfo(ContactsStorage storage) async {
    final params = {
      "Storage": storage.id,
    };

    final body = new WebMailApiBody(
      method: "GetContactsInfo",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    return ContactInfoMapper.allFromNetwork(Map<String,dynamic>.from(result as Map), storage.id);
  }

  @override
  Future<Contact> addContact(Contact contact) async {
    final params = {
      "Contact": ContactMapper.toNetwork(contact),
    };

    final body = new WebMailApiBody(
      method: "CreateContact",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    return contact.copyWith(
      uuid: result["UUID"] as String,
      uuidPlusStorage: result["UUID"] + contact.storage as String,
      eTag: result["ETag"] as String,
    );
  }

  @override
  Future<void> editContact(Contact contact) async {
    final params = {
      "Contact": ContactMapper.toNetwork(contact),
    };

    final body = new WebMailApiBody(
      method: "UpdateContact",
      parameters: json.encode(params),
    );

    return contactsModule.post(body);
  }

  @override
  Future<void> deleteContacts(List<String> uuids) {
    final params = {
      "UUIDs": uuids,
    };

    final body = new WebMailApiBody(
      method: "DeleteContacts",
      parameters: json.encode(params),
    );

    return contactsModule.post(body);
  }

  @override
  Future<void> addContactsToGroup(String groupUuid, List<String> uuids) {
    final params = {
      "GroupUUID": groupUuid,
      "ContactUUIDs": uuids,
    };

    final body = new WebMailApiBody(
      method: "AddContactsToGroup",
      parameters: json.encode(params),
    );

    return contactsModule.post(body);
  }

  @override
  Future<void> removeContactsFromGroup(String groupUuid, List<String> uuids) {
    final params = {
      "GroupUUID": groupUuid,
      "ContactUUIDs": uuids,
    };

    final body = new WebMailApiBody(
      method: "RemoveContactsFromGroup",
      parameters: json.encode(params),
    );

    return contactsModule.post(body);
  }

  @override
  Future<List<ContactsGroup>> getGroups() async {
    final body = new WebMailApiBody(
      method: "GetGroups",
    );

    final result = await contactsModule.post(body);
    return ContactsGroupMapper.allFromNetwork(result as List);
  }

  @override
  Future<ContactsGroup> createGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      method: "CreateGroup",
      parameters: json.encode({"Group": ContactsGroupMapper.toNetwork(group)}),
    );

    final result = await contactsModule.post(body);
    if (result is! String) throw "addGroup must be a string";
    return group.copyWith(uuid: result as String);
  }

  @override
  Future<bool> updateGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      method: "UpdateGroup",
      parameters: json.encode({"Group": ContactsGroupMapper.toNetwork(group)}),
    );

    final result = await contactsModule.post(body);
    return result as bool;
  }

  @override
  Future<bool> deleteGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      method: "DeleteGroup",
      parameters: json.encode({"UUID": group.uuid}),
    );

    final result = await contactsModule.post(body);
    return result as bool;
  }
}
