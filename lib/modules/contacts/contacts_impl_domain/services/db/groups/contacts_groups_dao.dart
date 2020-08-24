import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'contacts_groups_table.dart';

part 'contacts_groups_dao.g.dart';

@UseDao(tables: [ContactsGroups])
class ContactsGroupsDao extends DatabaseAccessor<AppDatabase>
    with _$ContactsGroupsDaoMixin {
  ContactsGroupsDao(AppDatabase db) : super(db);

  Future<List<ContactsGroupsTable>> getGroups(int userLocalId) {
    return (select(contactsGroups)
          ..where((c) => c.userLocalId.equals(userLocalId)))
        .get();
  }

  Future<void> addGroups(List<ContactsGroupsTable> newGroups) async {
    batch((b) => b.insertAll(
          contactsGroups,
          newGroups,
          mode: InsertMode.insertOrReplace,
        )).catchError((_) {});
  }

  Future<void> updateGroups(List<ContactsGroupsCompanion> updatedGroups) {
    return transaction(() async {
      for (final group in updatedGroups) {
        await (update(contactsGroups)
              ..where((g) => g.uuid.equals(group.uuid.value)))
            .write(group);
      }
    });
  }

  Future<void> deleteGroups(List<String> uuids) async {
    return (delete(contactsGroups)..where((g) => g.uuid.isIn(uuids))).go();
  }

  Future<void> deleteGroupsOfUser(int userLocalId) async {
    return (delete(contactsGroups)
          ..where((g) => g.userLocalId.equals(userLocalId)))
        .go();
  }
}
