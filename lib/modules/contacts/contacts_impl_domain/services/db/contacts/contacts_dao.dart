import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'contacts_table.dart';

part 'contacts_dao.g.dart';

@DriftAccessor(tables: [ContactsTable])
class ContactsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  Future<void> addContacts(List<ContactDb> newContacts) async {
    await batch((b) => b.insertAll(
          contactsTable,
          newContacts,
          mode: InsertMode.insertOrReplace,
        ));
  }

  Future<void> deleteContacts(List<String> uuids) {
    return (delete(contactsTable)..where((c) => c.uuid.isIn(uuids))).go();
  }

  Future<void> deleteContactsOfUser(int userLocalId) {
    return (delete(contactsTable)
          ..where((c) => c.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<List<ContactDb>> getAllContacts() {
    return (select(contactsTable)
          ..orderBy([
            (c) => OrderingTerm(expression: c.storage.collate(Collate.noCase)),
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .get();
  }

  Future<List<ContactDb>> getContacts(int userLocalId,
      {required List<String>? storages, required String? groupUuid, required String? pattern}) {
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
          ..where((c) => groupUuid != null
              ? c.groupUUIDs.like("%$groupUuid%")
              : Constant(true))
          ..orderBy([
            (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
            (c) =>
                OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
          ]))
        .get();
  }

  SimpleSelectStatement<$ContactsTableTable, ContactDb> _search(
      SimpleSelectStatement<$ContactsTableTable, ContactDb> select,
      String search) {
    if (search?.isNotEmpty == true) {
      return select
        ..where((c) =>
            c.viewEmail.like("%$search%") |
            c.businessEmail.like("%$search%") |
            c.otherEmail.like("%$search%") |
            c.personalEmail.like("%$search%") |
            c.fullName.like("%$search%"));
    } else {
      return select;
    }
  }

  Stream<List<ContactDb>> watchAllContacts(int userLocalId, String search) {
    return _search(
      (select(contactsTable)
        ..where((c) => c.userLocalId.equals(userLocalId))
        ..where((c) => c.storage.isNotIn([StorageNames.collected])))
        ..orderBy([
          (c) => OrderingTerm(expression: c.fullName.collate(Collate.noCase)),
          (c) => OrderingTerm(expression: c.viewEmail.collate(Collate.noCase)),
        ]),
      search,
    ).watch();
  }

  Stream<List<ContactDb>> watchContactsFromStorage(
      int userLocalId, String storage, String search) {
    return _search(
            select(contactsTable)
              ..where((c) => c.userLocalId.equals(userLocalId))
              ..where((c) => c.storage.equals(storage))
              ..orderBy([
                (c) => OrderingTerm(
                    expression: c.fullName.collate(Collate.noCase)),
                (c) => OrderingTerm(
                    expression: c.viewEmail.collate(Collate.noCase)),
              ]),
            search)
        .watch();
  }

  Stream<List<ContactDb>> watchContactsFromGroup(
      int userLocalId, String groupUuid, String search) {
    return _search(
            select(contactsTable)
              ..where((c) => c.userLocalId.equals(userLocalId))
              ..where((c) => c.groupUUIDs.like("%$groupUuid%"))
              ..orderBy([
                (c) => OrderingTerm(
                    expression: c.fullName.collate(Collate.noCase)),
                (c) => OrderingTerm(
                    expression: c.viewEmail.collate(Collate.noCase)),
              ]),
            search)
        .watch();
  }

  Future<void> updateContacts(List<ContactsTableCompanion> updatedContacts) async{
    try {
      return transaction(() async {
        for (final contact in updatedContacts) {
          await (update(contactsTable)
                ..where((c) => c.uuid.equals(contact.uuid.value)))
              .write(contact);
        }
      });
    } catch (err) {
      return;
    }
  }

  Future<void> addKey(String mail, String key) async {
    try {
      return transaction(() async {
        await (update(contactsTable)..where((c) => c.viewEmail.equals(mail)))
            .write(ContactsTableCompanion(pgpPublicKey: Value(key)));
      });
    } catch (err) {
      return null;
    }
  }

  Future<ContactDb?> getContactWithPgpKey(String email) {
    return (select(contactsTable)
          ..where((item) => item.pgpPublicKey.isNotNull() & item.pgpPublicKey.equals('').not())
          ..where((item) => item.viewEmail.equals(email)))
        .get()
        .then((items) {
      if (items.isEmpty) {
        return null;
      }
      return items.first;
    });
  }

  Future<List<ContactDb>> getContactsWithPgpKey() {
    return (select(contactsTable)
          ..where((item) =>
              item.pgpPublicKey.like("%-----BEGIN PGP PUBLIC KEY BLOCK-----%")))
        .get();
  }

  Future deleteContactKey(String mail) async{
    try {
      return transaction(() async {
        await (update(contactsTable)..where((c) => c.viewEmail.equals(mail)))
            .write(
          ContactsTableCompanion(
            pgpPublicKey: Value(null),
          ),
        );
      });
    } catch (err, st) {
      print(err);
      print(st);
      return null;
    }
  }

  Future<ContactDb?> getContactByEmail(String mail) {
    return (select(contactsTable)..where((item) => item.viewEmail.equals(mail)))
        .get()
        .then((item) {
      if (item.isEmpty) {
        return null;
      }

      return item.first;
    });
  }

  Future<List<ContactDb>> getContactsByEmail(String mail) {
    return (select(contactsTable)..where((item) => item.viewEmail.equals(mail)))
        .get();
  }

  Future<ContactDb> getContactById(int entityId) {
    return (select(contactsTable)
          ..where((item) => item.entityId.equals(entityId)))
        .getSingle();
  }
}
