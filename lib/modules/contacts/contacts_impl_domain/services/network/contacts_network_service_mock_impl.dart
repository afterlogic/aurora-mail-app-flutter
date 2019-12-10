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

class ContactsNetworkServiceMockImpl implements ContactsNetworkService {
  final _storages = new List<ContactsStorage>();

  ContactsNetworkServiceMockImpl(this.contactsModule);

  @override
  Future<List<ContactsStorage>> getContactStorages() async {
    final result = [
      {
        "Id": "personal",
        "Name": "Personal",
        "CTag": 7
      },
    ];
    return ContactsStorageMapper.fromNetwork(result);
  }

  @override
  Future<List<Contact>> getContactsByUids(ContactsStorage storage,
      List<String> uids) async {
    final params = {
      "Storage": storage.id,
      "Uids": uids,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    final result = await contactsModule.post<List<Map<String, dynamic>>>(body);
    return ContactMapper.fromNetwork(result);
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

    final result = await contactsModule.post<Map<String, dynamic>>(body);
    return ContactInfoMapper.fromNetwork(result);
  }

  @override
  Future<List<ContactsGroup>> getGroups() async {
    final body = new WebMailApiBody(
      method: "GetGroups",
      parameters: null,
    );

    final result = await contactsModule.post<List<Map<String, dynamic>>>(body);
    return ContactsGroupMapper.fromNetwork(result);
  }
}
