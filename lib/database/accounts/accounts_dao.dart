//@dart=2.9
import 'package:aurora_mail/database/app_database.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';

import 'accounts_table.dart';

part 'accounts_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(AppDatabase db) : super(db);

  Future<void> addAccounts(List<Account> newAccounts) {
    return batch((b) {
      return b.insertAll(accounts, newAccounts);
    });
  }

  Future<List<Account>> getAccounts(int userLocalId) async {
    // selects separated for handling case with large signature
    final accountLocalIdsQuery = selectOnly(accounts)
      ..where(accounts.userLocalId.equals(userLocalId))
      ..addColumns([accounts.localId]);

    final Set<int> accountLocalIds =
        (await accountLocalIdsQuery.map((a) => a.read(accounts.localId)).get())
            .toSet();

    final Map<int, String> signatureMap = {};

    for (int accountLocalId in accountLocalIds) {
      final signatureQuery = selectOnly(accounts)
        ..where(accounts.localId.equals(accountLocalId))
        ..addColumns([accounts.signature]);
      try {
        final signatureLocalIdPair = await signatureQuery
            .map((a) => {accountLocalId: a.read(accounts.signature)})
            .getSingle();
        signatureMap.addAll(signatureLocalIdPair);
      } catch (e, st) {
        print(e);
        print(st);
        continue;
      }
    }

    final query = selectOnly(accounts)
      ..where(accounts.localId.isIn(accountLocalIds))
      ..addColumns([
        accounts.localId,
        accounts.userLocalId,
        accounts.entityId,
        accounts.idUser,
        accounts.uuid,
        accounts.parentUuid,
        accounts.moduleName,
        accounts.useToAuthorize,
        accounts.email,
        accounts.friendlyName,
        accounts.useSignature,
        accounts.serverId,
        accounts.foldersOrderInJson,
        accounts.useThreading,
        accounts.saveRepliesToCurrFolder,
        accounts.accountId,
        accounts.allowFilters,
        accounts.allowForward,
        accounts.allowAutoResponder
      ]);
    return query.map(
      (a) {
        final int localId = a.read(accounts.localId);

        return Account(
          localId: localId,
          userLocalId: a.read(accounts.userLocalId),
          entityId: a.read(accounts.entityId),
          idUser: a.read(accounts.idUser),
          uuid: a.read(accounts.uuid),
          parentUuid: a.read(accounts.parentUuid),
          moduleName: a.read(accounts.moduleName),
          useToAuthorize: a.read(accounts.useToAuthorize),
          email: a.read(accounts.email),
          friendlyName: a.read(accounts.friendlyName),
          useSignature: a.read(accounts.useSignature),
          signature:
              signatureMap.containsKey(localId) ? signatureMap[localId] : "",
          serverId: a.read(accounts.serverId),
          foldersOrderInJson: a.read(accounts.foldersOrderInJson),
          useThreading: a.read(accounts.useThreading),
          saveRepliesToCurrFolder: a.read(accounts.saveRepliesToCurrFolder),
          accountId: a.read(accounts.accountId),
          allowFilters: a.read(accounts.allowFilters),
          allowForward: a.read(accounts.allowForward),
          allowAutoResponder: a.read(accounts.allowAutoResponder),
        );
      },
    ).get();
  }

  Future<Account> getAccount(int localId) async {
    // selects separated for handling case with large signature

    String signature;

    final signatureQuery = selectOnly(accounts)
      ..where(accounts.localId.equals(localId))
      ..addColumns([accounts.signature]);
    try {
      signature = await signatureQuery
          .map((a) => a.read(accounts.signature))
          .getSingle();
    } catch (e, st) {
      print(e);
      print(st);
    } finally {
      final query = selectOnly(accounts)
        ..where(accounts.localId.equals(localId))
        ..addColumns([
          accounts.localId,
          accounts.userLocalId,
          accounts.entityId,
          accounts.idUser,
          accounts.uuid,
          accounts.parentUuid,
          accounts.moduleName,
          accounts.useToAuthorize,
          accounts.email,
          accounts.friendlyName,
          accounts.useSignature,
          accounts.serverId,
          accounts.foldersOrderInJson,
          accounts.useThreading,
          accounts.saveRepliesToCurrFolder,
          accounts.accountId,
          accounts.allowFilters,
          accounts.allowForward,
          accounts.allowAutoResponder
        ]);
      return query.map(
        (a) {
          return Account(
            localId: a.read(accounts.localId),
            userLocalId: a.read(accounts.userLocalId),
            entityId: a.read(accounts.entityId),
            idUser: a.read(accounts.idUser),
            uuid: a.read(accounts.uuid),
            parentUuid: a.read(accounts.parentUuid),
            moduleName: a.read(accounts.moduleName),
            useToAuthorize: a.read(accounts.useToAuthorize),
            email: a.read(accounts.email),
            friendlyName: a.read(accounts.friendlyName),
            useSignature: a.read(accounts.useSignature),
            signature: signature ?? "",
            serverId: a.read(accounts.serverId),
            foldersOrderInJson: a.read(accounts.foldersOrderInJson),
            useThreading: a.read(accounts.useThreading),
            saveRepliesToCurrFolder: a.read(accounts.saveRepliesToCurrFolder),
            accountId: a.read(accounts.accountId),
            allowFilters: a.read(accounts.allowFilters),
            allowForward: a.read(accounts.allowForward),
            allowAutoResponder: a.read(accounts.allowAutoResponder),
          );
        },
      ).getSingleOrNull();
    }
  }

  Future<void> deleteAccountsOfUser(int userLocalId) {
    return (delete(accounts)..where((a) => a.userLocalId.equals(userLocalId)))
        .go();
  }

  Future<void> deleteAccountById(int localId) {
    return (delete(accounts)..where((a) => a.localId.equals(localId))).go();
  }

  Future updateAccount(Account server, int localId) {
    return update(accounts).replace(server.copyWith(localId: localId));
  }
}
