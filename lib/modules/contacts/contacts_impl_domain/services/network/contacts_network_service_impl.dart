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

    final result = await contactsModule.post(body);
    final typedResult = new List<Map<String, dynamic>>.from(result);
    return ContactsStorageMapper.fromNetwork(typedResult);
  }

  @override
  Future<List<Contact>> getContactsByUids(
      ContactsStorage storage, List<String> uids) async {
    final params = {
      "Storage": storage.id,
      "Uids": uids,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    final typedResult = new List<Map<String, dynamic>>.from(result);
    return ContactMapper.fromNetwork(typedResult);
  }

  @override
  Future<List<ContactInfoItem>> getContactsInfo(ContactsStorage storage) async {
    final params = {
      "Storage": storage,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post(body);
    final typedResult = new Map<String, dynamic>.from(result);
    return ContactInfoMapper.fromNetwork(typedResult);
  }

  @override
  Future<List<ContactsGroup>> getGroups() async {
    final body = new WebMailApiBody(
      method: "GetGroups",
      parameters: null,
    );

    final result = await contactsModule.post(body);
    final typedResult = new List<Map<String, dynamic>>.from(result);
    return ContactsGroupMapper.fromNetwork(typedResult);
  }

  @override
  Future<ContactsGroup> addGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      module: "Contacts",
      method: "CreateGroup",
      parameters: json.encode({"Group": ContactsGroupMapper.toNetwork(group)}),
    );

    final result = await contactsModule.post<Map<String, dynamic>>(body);
    return ContactsGroupMapper.fromNetwork([result]).first;
  }

  @override
  Future<bool> editGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      module: "Contacts",
      method: "UpdateGroup",
      parameters: json.encode({"Group": ContactsGroupMapper.toNetwork(group)}),
    );

    final result = await contactsModule.post<bool>(body);
    return result;
  }

  @override
  Future<bool> deleteGroup(ContactsGroup group) async {
    final body = new WebMailApiBody(
      module: "Contacts",
      method: "DeleteGroup",
      parameters: json.encode({"UUID": group.uuid}),
    );

    final result = await contactsModule.post<bool>(body);
    return result;
  }
}
