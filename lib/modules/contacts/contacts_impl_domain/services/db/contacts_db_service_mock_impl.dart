import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';

class ContactsDbServiceMockImpl implements ContactsDbService {
  static var storages = new List<ContactsStorage>();
  static var groups = new List<ContactsGroup>();
  static var infos = new List<ContactInfoItem>();
  static var contacts = new List<Contact>();

  @override
  Future<List<ContactsStorage>> getStorages(int userServerId) async => storages;

  @override
  Future<void> deleteStorages(List<int> sqliteIds) async {
    storages.removeWhere((s) => sqliteIds.contains(s.sqliteId));
  }

  @override
  Future<void> addStorages(
      List<ContactsStorage> newStorages, int userId) async {
    newStorages.forEach((storage) {
      int sqliteId = 0;
      while (storages.where((s) => s.sqliteId == sqliteId).isNotEmpty) {
        sqliteId++;
      }
      storages.add(new ContactsStorage(
          sqliteId: sqliteId,
          id: storage.id,
          name: storage.name,
          cTag: storage.cTag,
          display: storage.display,
          contactsInfo: storage.contactsInfo));
    });
  }

  @override
  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true}) async {
    for (final storage in updatedStorages) {
      storages.removeWhere((s) => s.sqliteId == storage.sqliteId);
      storages.add(storage);
    }
  }

  @override
  Future<List<Contact>> getContacts(
      int userServerId, ContactsStorage storage) async {
    return contacts..where((c) => c.storage == storage.id).toList();
  }

  @override
  Future<void> addContacts(List<Contact> newContacts) async {
    newContacts.forEach((c) {
      contacts.add(new Contact(
        entityId: c.entityId,
        uuid: c.uuid,
        idUser: c.idUser,
        idTenant: c.idTenant,
        storage: c.storage,
        fullName: c.fullName,
        useFriendlyName: c.useFriendlyName,
        viewEmail: c.viewEmail,
        eTag: c.eTag,
        frequency: c.frequency,
        dateModified: c.dateModified,
        davContactsUid: c.davContactsUid,
        davContactsVCardUid: c.davContactsVCardUid,
        groupUUIDs: c.groupUUIDs,
      ));
    });
  }

  @override
  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true}) async {
    for (final contact in updatedContacts) {
      contacts.removeWhere((c) => c.uuid == contact.uuid);
      contacts.add(contact);
    }
  }

  @override
  Future<void> deleteContacts(List<String> uuids) async {
    contacts.removeWhere((c) => uuids.contains(c.uuid));
  }

  @override
  Future<List<ContactsGroup>> getGroups(int userServerId) async => groups;

  @override
  Future<void> addGroups(List<ContactsGroup> newGroups) async {
    newGroups.forEach((g) {
      groups
          .add(new ContactsGroup(idUser: g.idUser, uuid: g.uuid, name: g.name));
    });
  }

  @override
  Future<void> deleteGroups(List<String> uuids) async {
    groups.removeWhere((c) => uuids.contains(c.uuid));
  }

  @override
  Future<void> editGroups(List<ContactsGroup> newGroups) async {
    groups.removeWhere((oldItem) {
      return newGroups.firstWhere(
            (newItem) => newItem.uuid == oldItem,
            orElse: () => null,
          ) !=
          null;
    });
    groups.addAll(newGroups);
  }

  @override
  Stream<List<Contact>> watchContacts(
      int userServerId, ContactsStorage storage) {
    // TODO: implement watchContacts
    return null;
  }
}
