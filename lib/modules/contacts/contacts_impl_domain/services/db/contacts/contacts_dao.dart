import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_table.dart';

part 'contacts_dao.g.dart';

@UseDao(tables: [Contacts])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  Future<void> addContacts(List<ContactsTable> newContacts) async {
    await batch((b) =>
        b.insertAll(contacts, newContacts, mode: InsertMode.insertOrReplace));
  }

  Future<void> deleteContacts(List<String> uuids) {
    return (delete(contacts)..where((c) => c.uuid.isIn(uuids))).go();
  }

  Future<void> deleteContactsOfUser(int userLocalId) {
    return (delete(contacts)..where((c) => c.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<List<ContactsTable>> getContacts(int userLocalId,
      {List<String> storages, String pattern}) {
    return (select(contacts)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) {
            if (pattern != null && pattern.isNotEmpty) {
              return c.fullName.like("%$pattern%") |
                  c.viewEmail.like("%$pattern%");
            } else {
              return Constant(true);
            }
          })
          ..where((c) =>
              storages != null ? c.storage.isIn(storages) : Constant(true))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .get();
  }

  Stream<List<ContactsTable>> watchAllContacts(int userLocalId) {
    return (select(contacts)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.storage.isNotIn([StorageNames.collected]))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Stream<List<ContactsTable>> watchContactsFromStorage(
      int userLocalId, String storage) {
    return (select(contacts)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.storage.equals(storage))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Stream<List<ContactsTable>> watchContactsFromGroup(
      int userLocalId, String groupUuid) {
    return (select(contacts)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.groupUUIDs.like("%$groupUuid%"))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Future<void> updateContacts(List<ContactsCompanion> updatedContacts) {
    try {
      return transaction(() async {
        for (final contact in updatedContacts) {
          await (update(contacts)
                ..where((c) => c.uuid.equals(contact.uuid.value)))
              .write(contact);
        }
      });
    } catch (err) {
      return null;
    }
  }
}
