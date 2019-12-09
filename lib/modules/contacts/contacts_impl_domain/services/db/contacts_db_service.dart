import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts_db_service_impl.dart';

abstract class ContactsDbService {

  factory ContactsDbService(AppDatabase db) => ContactsDbServiceImpl(db);

  Future<List<ContactsTable>> getContacts(int userServerId, String storage);

  Future<void> addContacts(List<ContactsTable> newContacts);

  Future<void> deleteContacts(List<String> uuids);

  Future<void> updateContacts(List<ContactsCompanion> updatedContacts);

  Future<List<ContactsStoragesTable>> getStorages(int userServerId, String storage);

  Future<void> addStorages(List<ContactsStoragesTable> newStorages);

  Future<void> deleteStorages(List<int> sqliteIds);

  Future<List<ContactsGroupsTable>> getGroups(int userServerId, String storage);

  Future<void> addGroups(List<ContactsGroupsTable> newGroups);

  Future<void> deleteGroups(List<String> uuids);
}
