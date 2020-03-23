import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_table.dart';

part 'contacts_dao.g.dart';

@UseDao(tables: [ContactsTable])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  Future<void> addContacts(List<ContactDb> newContacts) async {
    await batch((b) =>
        b.insertAll(contactsTable, newContacts, mode: InsertMode.insertOrReplace));
  }

  Future<void> deleteContacts(List<String> uuids) {
    return (delete(contactsTable)..where((c) => c.uuid.isIn(uuids))).go();
  }

  Future<void> deleteContactsOfUser(int userLocalId) {
    return (delete(contactsTable)..where((c) => c.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<List<ContactDb>> getContacts(int userLocalId,
      {List<String> storages, String pattern}) {
    return (select(contactsTable)
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

  Stream<List<ContactDb>> watchAllContacts(int userLocalId) {
    return (select(contactsTable)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.storage.isNotIn([StorageNames.collected]))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Stream<List<ContactDb>> watchContactsFromStorage(
      int userLocalId, String storage) {
    return (select(contactsTable)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.storage.equals(storage))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Stream<List<ContactDb>> watchContactsFromGroup(
      int userLocalId, String groupUuid) {
    return (select(contactsTable)
          ..where((c) => c.userLocalId.equals(userLocalId))
          ..where((c) => c.groupUUIDs.like("%$groupUuid%"))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .watch();
  }

  Future<void> updateContacts(List<ContactsTableCompanion> updatedContacts) {
    try {
      return transaction(() async {
        for (final contact in updatedContacts) {
          await (update(contactsTable)
                ..where((c) => c.uuid.equals(contact.uuid.value)))
              .write(contact);
        }
      });
    } catch (err) {
      return null;
    }
  }
}
