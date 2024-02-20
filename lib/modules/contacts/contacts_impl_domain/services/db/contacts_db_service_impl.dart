//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contact_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_group_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/mappers/contacts_storage_mapper.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_dao.dart';

class ContactsDbServiceImpl implements ContactsDbService {
  static final ContactsDbServiceImpl _singleton =
      ContactsDbServiceImpl._internal();
  static AppDatabase _db;

  ContactsDbServiceImpl._internal();

  factory ContactsDbServiceImpl(AppDatabase db) {
    ContactsDbServiceImpl._db = db;
    return _singleton;
  }

  final _contactsDao = ContactsDao(_db);
  final _groupsDao = ContactsGroupsDao(_db);
  final _storagesDao = ContactsStoragesDao(_db);

  @override
  Future<void> addContacts(List<Contact> newContacts) async {
    final formatted = ContactMapper.toDB(newContacts);
    await _contactsDao.addContacts(formatted);
  }

  @override
  Future<void> addGroups(List<ContactsGroup> newGroups) {
    final formatted = ContactsGroupMapper.toDB(newGroups);
    return _groupsDao.addGroups(formatted);
  }

  @override
  Future<void> addStorages(
      List<ContactsStorage> newStorages, int userId) async {
    if (newStorages?.isEmpty == true) return;
    final formatted = ContactsStorageMapper.toDB(newStorages, userId);
    try {
      await _storagesDao.addStorages(formatted);
    } catch (err) {
      print('ERROR ContactsDbServiceImpl.addStorages(): $err');
    }
  }

  @override
  Future<void> deleteContacts(List<String> uuids) =>
      _contactsDao.deleteContacts(uuids);

  @override
  Future<void> deleteGroups(List<String> uuids) =>
      _groupsDao.deleteGroups(uuids);

  @override
  Future<void> deleteStorages(List<int> sqliteIds) =>
      _storagesDao.deleteStorages(sqliteIds);

  @override
  Future<List<Contact>> getAllContacts() async {
    final result = await _contactsDao.getAllContacts();
    return ContactMapper.listFromDB(result);
  }

  @override
  Future<List<Contact>> getContacts(int userLocalId,
      {List<String> storages, String groupUuid, String pattern}) async {
    final result = await _contactsDao.getContacts(
      userLocalId,
      storages: storages,
      groupUuid: groupUuid,
      pattern: pattern,
    );
    return ContactMapper.listFromDB(result);
  }

  @override
  Stream<List<Contact>> watchAllContacts(int userLocalId, String search) {
    final result = _contactsDao.watchAllContacts(userLocalId, search);
    return result.map((data) => ContactMapper.listFromDB(data));
  }

  @override
  Stream<List<Contact>> watchContactsFromStorage(
      int userLocalId, String storage, String search) {
    final result =
        _contactsDao.watchContactsFromStorage(userLocalId, storage, search);
    return result.map((data) => ContactMapper.listFromDB(data));
  }

  @override
  Stream<List<Contact>> watchContactsFromGroup(
      int userLocalId, String group, String search) {
    final result =
        _contactsDao.watchContactsFromGroup(userLocalId, group, search);
    return result.map((data) => ContactMapper.listFromDB(data));
  }

  @override
  Future<List<ContactsGroup>> getGroups(int userLocalId) async {
    final result = await _groupsDao.getGroups(userLocalId);
    return ContactsGroupMapper.fromDB(result);
  }

  @override
  Future<List<ContactsStorage>> getStorages(int userLocalId) async {
    final result = await _storagesDao.getStorages(userLocalId);
    return ContactsStorageMapper.fromDB(result);
  }

  @override
  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true}) {
    final formatted = ContactMapper.toDB(updatedContacts);
    final companions =
        formatted.map((c) => c.toCompanion(nullToAbsent)).toList();
    return _contactsDao.updateContacts(companions);
  }

  @override
  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true}) {
    final formatted = ContactsStorageMapper.toDB(updatedStorages, userId);
    final companions =
        formatted.map((c) => c.toCompanion(nullToAbsent)).toList();
    return _storagesDao.updateStorages(companions);
  }

  Future<void> editGroups(List<ContactsGroup> newGroups) {
    final formatted = ContactsGroupMapper.toDB(newGroups);
    final companions = formatted.map((c) => c.toCompanion(true)).toList();
    return _groupsDao.updateGroups(companions);
  }

  @override
  Future<Contact> getContactWithPgpKey(String email) {
    return _contactsDao
        .getContactWithPgpKey(email)
        .then((item) => ContactMapper.fromDB(item));
  }

  @override
  Future<List<Contact>> getContactsWithPgpKey() {
    return _contactsDao
        .getContactsWithPgpKey()
        .then((items) => ContactMapper.listFromDB(items));
  }

  @override
  Future deleteContactKey(String mail) {
    return _contactsDao.deleteContactKey(mail);
  }

  Future addKeyToContact(String viewEmail, String pgpPublicKey) {
    return _contactsDao.addKey(viewEmail, pgpPublicKey);
  }

  @override
  Future<Contact> getContactByEmail(String mail) {
    return _contactsDao
        .getContactByEmail(mail)
        .then((item) => ContactMapper.fromDB(item));
  }

  Future<Contact> getContactById(int entityId) {
    return _contactsDao
        .getContactById(entityId)
        .then((item) => ContactMapper.fromDB(item));
  }
}
