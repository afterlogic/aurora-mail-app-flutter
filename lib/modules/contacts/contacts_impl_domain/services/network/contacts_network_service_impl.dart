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
  final int userId;

  ContactsNetworkServiceImpl(this.contactsModule, this.userId);

  @override
  Future<List<ContactsStorage>> getContactStorages(int userLocalId) async {
    final body = new WebMailApiBody(
      method: "GetContactStorages",
      parameters: null,
    );

    final result = await contactsModule.post(body) as List;
    return ContactsStorageMapper.allFromNetwork(result, userLocalId);
  }

  @override
  Future<List<Contact>> getContactsByUids({
    ContactsStorage storage,
    List<String> uuids,
    int userLocalId,
  }) async {
    if (uuids == null || uuids.isEmpty) {
      return new List<Contact>();
    }

    final params = {
      "Storage": storage.id,
      "Uids": uuids,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    return ContactMapper.fromNetwork(result as List, userLocalId);
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
    return ContactInfoMapper.allFromNetwork(
        Map<String, dynamic>.from(result as Map), storage.id);
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
  Future<void> updateSharedContacts(List<String> uuids) async {
    final params = {
      "UUIDs": uuids,
    };

    final body = new WebMailApiBody(
      method: "UpdateSharedContacts",
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
  Future<List<ContactsGroup>> getGroups(int userLocalId) async {
    final body = new WebMailApiBody(
      method: "GetGroups",
    );

    final result = await contactsModule.post(body);
    return ContactsGroupMapper.allFromNetwork(result as List, userLocalId);
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

  Future<void> addKeyToContact(Contact contact) async {
    final body = new WebMailApiBody(
      module: "OpenPgpWebclient",
      method: "AddPublicKeyToContact",
      parameters: json.encode({
        "UserId": userId,
        "Email": contact.viewEmail,
        "Key": contact.pgpPublicKey,
      }),
    );

    final result = await contactsModule.post(body);
    return result as bool;
  }

  @override
  Future deleteContactKey(String mail) async {
    final body = new WebMailApiBody(
      module: "OpenPgpWebclient",
      method: "RemovePublicKeyFromContact",
      parameters: json.encode({
        "UserId": userId,
        "Email": mail,
      }),
    );

    final result = await contactsModule.post(body);
    return result as bool;
  }
}
