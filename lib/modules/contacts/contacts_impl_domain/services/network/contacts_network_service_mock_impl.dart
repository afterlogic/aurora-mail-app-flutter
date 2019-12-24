import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/network/contacts_network_service.dart';

class ContactsNetworkServiceMockImpl implements ContactsNetworkService {
  static var storages = new List<ContactsStorage>();
  static var groups = new List<ContactsGroup>();
  static var infos = new List<ContactInfoItem>();
  static var contacts = new List<Contact>();

  ContactsNetworkServiceMockImpl();

  @override
  Future<List<ContactsStorage>> getContactStorages() async => storages;

  @override
  Future<List<Contact>> getContactsByUids(
      ContactsStorage storage, List<String> uids) async {
    return contacts
      ..where((c) => c.storage == storage.id)
      ..where((c) => uids.contains(c.uuid)).toList();
  }

  @override
  Future<List<ContactInfoItem>> getContactsInfo(
          ContactsStorage storage) async =>
      infos;

  @override
  Future<List<ContactsGroup>> getGroups() async => groups;

  @override
  Future<ContactsGroup> createGroup(ContactsGroup group) async {
// todo   group.uuid = Random().nextInt(500).toString();
    groups.add(group);
    return group;
  }

  @override
  Future<bool> updateGroup(ContactsGroup group) async {
    final item = groups.firstWhere((item) => item.uuid == group.uuid,
        orElse: () => null);
    groups.remove(item);
    groups.add(item);
    return true;
  }

  @override
  Future<bool> deleteGroup(ContactsGroup group) async {
    final toRemove = groups.firstWhere((item) => group.uuid == item.uuid,
        orElse: () => null);
    groups.remove(toRemove);
    return toRemove != null;
  }

  @override
  Future<Contact> addContact(Contact contact) {
    // TODO: implement addContact
    return null;
  }

  @override
  Future<void> editContact(Contact contact) {
    // TODO: implement editContact
    return null;
  }

  @override
  Future<void> addContactsToGroup(String groupUuid, List<String> uuids) {
    // TODO: implement addContactsToGroup
    return null;
  }

  @override
  Future<void> deleteContacts(List<String> uuids) {
    // TODO: implement deleteContacts
    return null;
  }

  @override
  Future<void> removeContactsFromGroup(String groupUuid, List<String> uuids) {
    // TODO: implement removeContactsFromGroup
    return null;
  }
}
