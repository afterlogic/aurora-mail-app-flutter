import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';

class ContactsDbServiceMockImpl implements ContactsDbService {
  final _storages = new List<ContactsStorage>();

  @override
  Future<List<ContactsStorage>> getStorages(int userServerId) async =>
      _storages;

  @override
  Future<void> deleteStorages(List<int> sqliteIds) async {
    _storages.removeWhere((s) => sqliteIds.contains(s.sqliteId));
  }

  @override
  Future<void> addStorages(
      List<ContactsStorage> newStorages, int userId) async {
    newStorages.forEach((storage) {
      int sqliteId = 0;
      while (_storages.where((s) => s.sqliteId == sqliteId).isNotEmpty) {
        sqliteId++;
      }
      _storages.add(new ContactsStorage(
          sqliteId: sqliteId,
          id: storage.id,
          name: storage.name,
          cTag: storage.cTag,
          contactsInfo: storage.contactsInfo));
    });
  }

  @override
  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true}) async {
    for (final storage in updatedStorages) {
      _storages.removeWhere((s) => s.sqliteId == storage.sqliteId);
      _storages.add(storage);
    }
  }

  @override
  Future<void> addContacts(List<Contact> newContacts) {
    // TODO: implement addContacts
    return null;
  }

  @override
  Future<void> addGroups(List<ContactsGroup> newGroups) {
    // TODO: implement addGroups
    return null;
  }

  @override
  Future<void> deleteContacts(List<String> uuids) {
    // TODO: implement deleteContacts
    return null;
  }

  @override
  Future<void> deleteGroups(List<String> uuids) {
    // TODO: implement deleteGroups
    return null;
  }

  @override
  Future<List<Contact>> getContacts(int userServerId, String storage) {
    // TODO: implement getContacts
    return null;
  }

  @override
  Future<List<ContactsGroup>> getGroups(int userServerId, String storage) {
    // TODO: implement getGroups
    return null;
  }

  @override
  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true}) {
    // TODO: implement updateContacts
    return null;
  }
}
