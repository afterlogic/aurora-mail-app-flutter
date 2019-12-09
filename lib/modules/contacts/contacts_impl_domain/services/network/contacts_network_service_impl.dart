import 'dart:convert';

import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class ContactsNetworkServiceImpl implements ContactsNetworkService {
  final WebMailApi contactsModule;

  ContactsNetworkServiceImpl(this.contactsModule);

  @override
  Future<List<Map<String, dynamic>>> getContactStorages() async {
    final body = new WebMailApiBody(
      method: "GetContactStorages",
      parameters: null,
    );

    return contactsModule.post<List<Map<String, dynamic>>>(body);
  }

  @override
  Future<List<Map<String, dynamic>>> getContactsByUids(
      String storage, List<String> uids) {
    final params = {
      "Storage": storage,
      "Uids": uids,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    return contactsModule.post<List<Map<String, dynamic>>>(body);
  }

  @override
  Future<Map<String, dynamic>> getContactsInfo(String storage) {
    final params = {
      "Storage": storage,
    };

    final body = new WebMailApiBody(
      method: "GetContactsByUids",
      parameters: json.encode(params),
    );

    return contactsModule.post<Map<String, dynamic>>(body);
  }

  @override
  Future<List<Map<String, dynamic>>> getGroups() async {
    final body = new WebMailApiBody(
      method: "GetGroups",
      parameters: null,
    );

    return contactsModule.post<List<Map<String, dynamic>>>(body);
  }
}
