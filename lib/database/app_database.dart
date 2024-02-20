//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/account_identity/account_identity_table.dart';
import 'package:aurora_mail/database/aliases/aliases_table.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/pgp/pgp_key_model.dart';
import 'package:aurora_mail/database/white_mail/white_mail_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/converters/contacts_info_converter.dart';
import 'package:aurora_mail/modules/settings/models/sync_freq.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'accounts/accounts_table.dart';
import 'migration/drop_all.dart';
import 'migration/m2.dart';
import 'migration/m3.dart';
import 'migration/m4.dart';
import 'migration/m5.dart';
import 'migration/m6.dart';
import 'users/users_table.dart';

part 'app_database.g.dart';

typedef _Migration = Future Function(AppDatabase, Migrator);

class DBInstances {
  static final appDB = new AppDatabase();
}

@DriftDatabase(tables: [
  Mail,
  Folders,
  Users,
  Accounts,
  ContactsTable,
  ContactsGroups,
  ContactsStorages,
  PgpKeyModel,
  AccountIdentityTable,
  AliasesTable,
  WhiteMailTable,
])
class AppDatabase extends _$AppDatabase {
  final migrationCompleter = Completer();

  AppDatabase()
      : super(SqfliteQueryExecutor.inDatabaseFolder(path: 'app_db.sqlite'));

  Map<int, _Migration> get _migrationMap => {
        1: dropAll,
        2: m2,
        3: m3,
        4: m4,
        5: m5,
        6: m6
      };

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          final migrationMap = _migrationMap;
          for (var i = from; i < to; i++) {
            final migration = migrationMap[i];
            if (migration != null) {
              try {
                await migration(this, m);
              } catch (e) {
                print(e);
              }
            }
          }
        },
        beforeOpen: (OpeningDetails details) async {
          migrationCompleter.complete();
        },
      );

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 7;
}
