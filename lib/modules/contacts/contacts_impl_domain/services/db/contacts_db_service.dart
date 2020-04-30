import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service_impl.dart';

abstract class ContactsDbService {
  factory ContactsDbService(AppDatabase db) {
    return ContactsDbServiceImpl(db);
  }

  Stream<List<Contact>> watchAllContacts(int userLocalId, String search);

  Stream<List<Contact>> watchContactsFromStorage(
      int userLocalId, String storage, String search);

  Stream<List<Contact>> watchContactsFromGroup(
      int userLocalId, String group, String search);

  Future<List<Contact>> getContacts(int userLocalId,
      {List<String> storages, String pattern});

  Future<void> addContacts(List<Contact> newContacts);

  Future<void> deleteContacts(List<String> uuids);

  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true});

  Future<List<ContactsStorage>> getStorages(int userLocalId);

  Future<void> addStorages(List<ContactsStorage> newStorages, int userId);

  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true});

  Future<void> deleteStorages(List<int> sqliteIds);

  Future<List<ContactsGroup>> getGroups(int userLocalId);

  Future<void> editGroups(List<ContactsGroup> newGroups);

  Future<void> addGroups(List<ContactsGroup> newGroups);

  Future<void> deleteGroups(List<String> uuids);

  Future<Contact> getContactWithPgpKey(String email);

  Future<List<Contact>> getContactsWithPgpKey();

  Future deleteContactKey(String mail);

  Future addKeyToContact(String viewEmail, String pgpPublicKey);

  Future<Contact> getContactByEmail(String mail);

  Future<Contact> getContactById(int entityId);
}
