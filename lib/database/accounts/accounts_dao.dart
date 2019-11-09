import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'accounts_table.dart';

part 'accounts_dao.g.dart';

@UseDao(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  Future<void> addAccounts(List<Account> newAccounts) {
    return into(accounts).insertAll(newAccounts);
  }

  Future<List<Account>> getAccounts(int userServerId) {
    return (select(accounts)..where((a) => a.idUser.equals(userServerId)))
        .get();
  }

  Future<void> deleteAccountsOfUser(int userServerId) {
    return (delete(accounts)..where((a) => a.idUser.equals(userServerId)))
        .go();
  }
}
