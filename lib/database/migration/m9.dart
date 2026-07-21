import 'dart:convert';

import 'package:drift/drift.dart';

import '../app_database.dart';

// Moves ContactsStorages.contacts_info out of a single JSON-blob TEXT column
// (one row per storage, holding every contact's sync metadata) into its own
// contact_infos table (one row per contact). A single storage's JSON blob
// could grow past Android's ~2MB SQLite CursorWindow-per-row limit for
// address books with many contacts, which made `SELECT * FROM
// contacts_storages` throw `Row too big to fit into CursorWindow` and broke
// the contacts screen entirely for those users.
Future m9(AppDatabase database, Migrator m) async {
  await m.createTable(database.contactInfos);
  await database.customStatement(
    'CREATE INDEX IF NOT EXISTS idx_contact_infos_user_storage '
    'ON contact_infos (user_local_id, storage);',
  );

  final oldRows = await database.customSelect(
    'SELECT user_local_id, server_id, contacts_info FROM contacts_storages;',
  ).get();

  final newRows = <ContactInfosCompanion>[];
  for (final row in oldRows) {
    final rawInfo = row.data['contacts_info'] as String?;
    if (rawInfo == null || rawInfo.isEmpty) continue;

    final userLocalId = row.read<int>('user_local_id');
    final storage = row.read<String>('server_id');

    List decoded;
    try {
      decoded = json.decode(rawInfo) as List;
    } catch (_) {
      // Corrupt/unparseable blob - nothing sane to migrate, skip it.
      continue;
    }

    for (final entry in decoded) {
      final map = Map<String, dynamic>.from(entry as Map);
      final uuid = map['uuid'] as String?;
      if (uuid == null) continue;

      newRows.add(ContactInfosCompanion.insert(
        userLocalId: userLocalId,
        storage: storage,
        uuid: uuid,
        eTag: Value(map['eTag'] as String?),
        hasBody: Value(map['hasBody'] as bool? ?? false),
        needsUpdate: Value(map['needsUpdate'] as bool? ?? false),
      ));
    }
  }

  if (newRows.isNotEmpty) {
    await database.batch((b) => b.insertAll(database.contactInfos, newRows));
  }

  // Drops the now-unused contacts_info column via drift's 12-step rebuild
  // (create new table without the column, copy remaining columns, swap in).
  await m.alterTable(TableMigration(database.contactsStorages));
}
