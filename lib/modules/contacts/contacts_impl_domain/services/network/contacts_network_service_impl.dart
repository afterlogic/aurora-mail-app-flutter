import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_info_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_group_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_storage_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';
import 'package:http/http.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsNetworkServiceImpl implements ContactsNetworkService {
  final WebMailApi contactsModule;
  final int userId;

  ContactsNetworkServiceImpl(this.contactsModule, this.userId);

  @override
  Future<List<ContactsStorage>> getContactStorages(int userLocalId) async {
    final body = new WebMailApiBody(
      method: "GetStorages",
      parameters: null,
    );

    final result = await contactsModule.post(body) as List;
    return ContactsStorageMapper.allFromNetwork(result, userLocalId);
  }

  @override
  Future<List<Contact>> getContactsByUids({
    required String storageId,
    List<String>? uuids,
    required int userLocalId,
  }) async {
    if (uuids == null || uuids.isEmpty) {
      return <Contact>[];
    }

    final params = {
      "Storage": storageId,
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
  Future<void> deleteContacts(String storage, List<String> uuids) {
    final params = {
      "Storage": storage,
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
    ///check for both types String and Map is for old API versions
    if (result is! String && result is! Map) throw "addGroup must be a string or map";
    final String uuid = result is String ? result : result["UUID"] as String;
    return group.copyWith(uuid: uuid);
  }

  @override
  Future<bool> updateGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      method: "UpdateGroup",
      parameters: json.encode({"Group": ContactsGroupMapper.toNetwork(group)}),
    );

    final result = await contactsModule.post(body);
    ///check for both types bool and Map is for old API versions
    if (result is! bool && result is! Map) throw "updateGroup must be a bool or map";
    final bool updateResult = result is bool ? result : (result["UUID"] as String).isNotEmpty;
    return updateResult;
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

  Future<List<String>> addKeyToContacts(List<Contact> contacts) async {
    final body = new WebMailApiBody(
      module: "OpenPgpWebclient",
      method: "AddPublicKeysToContacts",
      parameters: json.encode({
        "UserId": userId,
        "Keys": contacts
            .map(
              (item) => {
                "Email": item.viewEmail,
                "Name": item.fullName,
                "Key": item.pgpPublicKey,
              },
            )
            .toList(),
      }),
    );

    final result = await contactsModule.post(body);
    return (result as List).cast();
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

  @override
  Future importFromVcf(String content) async {
    final file = MultipartFile.fromString(
      "filename",
      content,
      filename: "import.vcf",
    );
    final body = new WebMailApiBody(
      module: "Contacts",
      method: "Import",
      parameters: json.encode({
        "GroupUUID": "",
        "Storage": "personal",
      }),
    );
    await contactsModule.multiPart(body, file);
  }
}
