import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'accounts_table.dart';

part 'accounts_dao.g.dart';

@UseDao(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  int get _accountId => AppStore.authState.accountId;
}
