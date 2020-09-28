import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'accounts_table.dart';

part 'accounts_dao.g.dart';

@UseDao(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  Future<void> addAccounts(List<Account> newAccounts) {
    return batch((b) {
      return b.insertAll(accounts, newAccounts);
    });
  }

  Future<List<Account>> getAccounts(int userLocalId) {
    return (select(accounts)
      ..where((a) => a.userLocalId.equals(userLocalId)))
        .get();
  }

  Future<Account> getAccount(int localId) async {
    final accountsFromDb =
    await (select(accounts)
      ..where((a) => a.localId.equals(localId))).get();

    if (accountsFromDb.isNotEmpty)
      return accountsFromDb[0];
    else
      return null;
  }

  Future<void> deleteAccountsOfUser(int userLocalId) {
    return (delete(accounts)
      ..where((a) => a.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<void> deleteAccountById(int localId) {
    return (delete(accounts)
      ..where((a) => a.localId.equals(localId)))
        .go();
  }

  Future updateAccount(Account server, int localId) {
    return update(accounts).replace(server.copyWith(localId: localId));
  }
}
