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

    final Set<int?> accountLocalIds =
        (await accountLocalIdsQuery.map((a) => a.read(accounts.localId)).get())
            .toSet();

    final Map<int, String?> signatureMap = {};

    for (int? accountLocalId in accountLocalIds) {
      if (accountLocalId == null) continue;
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
      (row) {
        final localId = row.read(accounts.localId);
        
        return Account(
          localId: localId,
          userLocalId: row.read(accounts.userLocalId)!,
          entityId: row.read(accounts.entityId)!,
          idUser: row.read(accounts.idUser)!,
          uuid: row.read(accounts.uuid)!,
          parentUuid: row.read(accounts.parentUuid)!,
          moduleName: row.read(accounts.moduleName)!,
          useToAuthorize: row.read(accounts.useToAuthorize)!,
          email: row.read(accounts.email)!,
          friendlyName: row.read(accounts.friendlyName)!,
          useSignature: row.read(accounts.useSignature)!,
          signature:
              signatureMap.containsKey(localId) ? signatureMap[localId] ?? "" : "",
          serverId: row.read(accounts.serverId)!,
          foldersOrderInJson: row.read(accounts.foldersOrderInJson)!,
          useThreading: row.read(accounts.useThreading)!,
          saveRepliesToCurrFolder: row.read(accounts.saveRepliesToCurrFolder)!,
          accountId: row.read(accounts.accountId)!,
          allowFilters: row.read(accounts.allowFilters)!,
          allowForward: row.read(accounts.allowForward)!,
          allowAutoResponder: row.read(accounts.allowAutoResponder)!,
        );
      },
    ).get();
  }

  Future<Account?> getAccount(int localId) async {
    // selects separated for handling case with large signature

    String? signature;

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
        (row) {
          return Account(
            localId: row.read(accounts.localId),
            userLocalId: row.read(accounts.userLocalId)!,
            entityId: row.read(accounts.entityId)!,
            idUser: row.read(accounts.idUser)!,
            uuid: row.read(accounts.uuid)!,
            parentUuid: row.read(accounts.parentUuid)!,
            moduleName: row.read(accounts.moduleName)!,
            useToAuthorize: row.read(accounts.useToAuthorize)!,
            email: row.read(accounts.email)!,
            friendlyName: row.read(accounts.friendlyName)!,
            useSignature: row.read(accounts.useSignature)!,
            signature: signature ?? "",
            serverId: row.read(accounts.serverId)!,
            foldersOrderInJson: row.read(accounts.foldersOrderInJson)!,
            useThreading: row.read(accounts.useThreading)!,
            saveRepliesToCurrFolder: row.read(accounts.saveRepliesToCurrFolder)!,
            accountId: row.read(accounts.accountId)!,
            allowFilters: row.read(accounts.allowFilters)!,
            allowForward: row.read(accounts.allowForward)!,
            allowAutoResponder: row.read(accounts.allowAutoResponder)!,
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
