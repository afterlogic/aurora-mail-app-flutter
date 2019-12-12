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

  final _contactsDao = new ContactsDao(_db);
  final _groupsDao = new ContactsGroupsDao(_db);
  final _storagesDao = new ContactsStoragesDao(_db);

  @override
  Future<void> addContacts(List<Contact> newContacts) {
    final formatted = ContactMapper.toDB(newContacts);
    return _contactsDao.addContacts(formatted);
  }

  @override
  Future<void> addGroups(List<ContactsGroup> newGroups) {
    final formatted = ContactsGroupMapper.toDB(newGroups);
    return _groupsDao.addGroups(formatted);
  }

  @override
  Future<void> addStorages(List<ContactsStorage> newStorages, int userId) {
    final formatted = ContactsStorageMapper.toDB(newStorages, userId);
    return _storagesDao.addStorages(formatted);
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
  Future<List<Contact>> getContacts(
      int userServerId, ContactsStorage storage) async {
    final result = await _contactsDao.getContacts(userServerId, storage.id);
    return ContactMapper.fromDB(result);
  }

  @override
  Future<List<ContactsGroup>> getGroups(
      int userServerId) async {
    final result = await _groupsDao.getGroups(userServerId);
    return ContactsGroupMapper.fromDB(result);
  }

  @override
  Future<List<ContactsStorage>> getStorages(int userServerId) async {
    final result = await _storagesDao.getStorages(userServerId);
    return ContactsStorageMapper.fromDB(result);
  }

  @override
  Future<void> updateContacts(List<Contact> updatedContacts,
      {bool nullToAbsent = true}) {
    final formatted = ContactMapper.toDB(updatedContacts);
    final companions = formatted.map((c) => c.createCompanion(nullToAbsent)).toList();
    return _contactsDao.updateContacts(companions);
  }

  @override
  Future<void> updateStorages(List<ContactsStorage> updatedStorages, int userId,
      {bool nullToAbsent = true}) {
    final formatted = ContactsStorageMapper.toDB(updatedStorages, userId);
    final companions = formatted.map((c) => c.createCompanion(nullToAbsent)).toList();
    return _storagesDao.updateStorages(companions);
  }

  Future<void> editGroups(List<ContactsGroup> newGroups) {
    final formatted = ContactsGroupMapper.toDB(newGroups);
    final companions = formatted.map((c) => c.createCompanion(true));
    return _groupsDao.updateGroups(companions);
  }
}
