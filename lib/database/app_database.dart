import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/pgp/pgp_key_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/converters/contacts_info_converter.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'accounts/accounts_table.dart';
import 'users/users_table.dart';

part 'app_database.g.dart';

class DBInstances {
  static final appDB = new AppDatabase();
}

@UseMoor(tables: [
  Mail,
  Folders,
  Users,
  Accounts,
  Contacts,
  ContactsGroups,
  ContactsStorages,
  PgpKeyModel
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'app_db.sqlite'));

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {}
      });

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
