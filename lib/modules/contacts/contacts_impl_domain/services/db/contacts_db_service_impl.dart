import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_dao.dart';

class ContactsDbServiceImpl implements ContactsDbService {
  // creating a singleton because Moor's Dao constructors need static variables
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
  Future<void> addContacts(List<ContactsTable> newContacts) => _contactsDao.addContacts(newContacts);

  @override
  Future<void> addGroups(List<ContactsGroupsTable> newGroups) => _groupsDao.addGroups(newGroups);

  @override
  Future<void> addStorages(List<ContactsStoragesTable> newStorages) => _storagesDao.addStorages(newStorages);

  @override
  Future<void> deleteContacts(List<String> uuids) => _contactsDao.deleteContacts(uuids);

  @override
  Future<void> deleteGroups(List<String> uuids) => _groupsDao.deleteGroups(uuids);

  @override
  Future<void> deleteStorages(List<int> sqliteIds) => _storagesDao.deleteStorages(sqliteIds);

  @override
  Future<List<ContactsTable>> getContacts(int userServerId, String storage) => _contactsDao.getContacts(userServerId, storage);

  @override
  Future<List<ContactsGroupsTable>> getGroups(int userServerId, String storage) => _groupsDao.getGroups(userServerId);

  @override
  Future<List<ContactsStoragesTable>> getStorages(int userServerId, String storage) => _storagesDao.getStorages(userServerId);

  @override
  Future<void> updateContacts(List<ContactsCompanion> updatedContacts) => _contactsDao.updateContacts(updatedContacts);
}
