import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_config.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service_impl.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

import 'contacts_network_service_mock_impl.dart';

abstract class ContactsNetworkService {
  factory ContactsNetworkService(WebMailApi contactsModule) {
    if (TEST_MODE)
      return ContactsNetworkServiceMockImpl();
    else
      return ContactsNetworkServiceImpl(contactsModule);
  }

  /// Returns a list of storages.
  /// [CTag] value changes when some storage data changes.
  Future<List<ContactsStorage>> getContactStorages();

  /// Returns a list of groups.
  Future<List<ContactsGroup>> getGroups();

  /// Returns a [CTag] and a list with contacts with hashes [ETag].
  /// [ETag] value changes when some contact data changes.
  Future<List<ContactInfoItem>> getContactsInfo(ContactsStorage storage);

  /// Get contacts by their uuids
  Future<List<Contact>> getContactsByUids(
      ContactsStorage storage, List<String> uids);

  Future<ContactsGroup> addGroup(ContactsGroup group);

  Future<bool> editGroup(ContactsGroup group);

  Future<bool> deleteGroup(ContactsGroup group);
}
