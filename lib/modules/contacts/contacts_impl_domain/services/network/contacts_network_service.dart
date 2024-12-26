import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service_impl.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

abstract class ContactsNetworkService {
  factory ContactsNetworkService(WebMailApi contactsModule, int serverId) {
    return ContactsNetworkServiceImpl(contactsModule, serverId);
  }

  /// Returns a list of storages.
  /// [CTag] value changes when some storage data changes.
  Future<List<ContactsStorage>> getContactStorages(int userLocalId);

  /// Returns a list of groups.
  Future<List<ContactsGroup>> getGroups(int userLocalId);

  /// Returns a [CTag] and a list with contacts with hashes [ETag].
  /// [ETag] value changes when some contact data changes.
  Future<List<ContactInfoItem>> getContactsInfo(ContactsStorage storage);

  /// Get contacts by their uuids
  Future<List<Contact>> getContactsByUids({
    List<String> uuids,
    int userLocalId,
  });

  Future<bool> updateContactPublicKeyFlags({required String uuid, bool? pgpEncryptMessages, bool? pgpSignMessages});

  Future<Contact> addContact(Contact contact);

  Future<void> editContact(Contact contact);

  Future<void> deleteContacts(String storage, List<String> uuids);

  Future<void> updateSharedContacts(List<String> uuids);

  Future<void> addContactsToGroup(String groupUuid, List<String> uuids);

  Future<void> removeContactsFromGroup(String groupUuid, List<String> uuids);

  Future<ContactsGroup> createGroup(ContactsGroup group);

  Future<bool> updateGroup(ContactsGroup group);

  Future<bool> deleteGroup(ContactsGroup group);

  Future<List<String>> addKeyToContacts(List<Contact> contacts);

  Future deleteContactKey(String mail);

  Future importFromVcf(String content);
}
