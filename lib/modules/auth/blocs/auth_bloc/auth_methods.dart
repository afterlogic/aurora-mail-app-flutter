import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/account_identity/accounts_identity_dao.dart';
import 'package:aurora_mail/database/accounts/accounts_dao.dart';
import 'package:aurora_mail/database/aliases/aliases_dao.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/modules/auth/repository/auth_local_storage.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_dao.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';

class AuthMethods {
  final _authApi = new AuthApi();
  final _authLocal = new AuthLocalStorage();
  final _usersDao = new UsersDao(DBInstances.appDB);
  final _accountIdentityDao = new AccountIdentityDao(DBInstances.appDB);
  final _aliasesDao = new AliasesDao(DBInstances.appDB);
  final _accountsDao = new AccountsDao(DBInstances.appDB);
  final _cryptoStorage = AppInjector.instance.cryptoStorage();

  Future<InitializerResponse> getUserAndAccountsFromDB() async {
    final selectedUserId = await _authLocal.getSelectedUserLocalId();
    final selectedAccountId = await _authLocal.getSelectedAccountId();
    if (selectedUserId == null) return null;

    final futures = [
      _usersDao.getUserByLocalId(selectedUserId),
      _accountsDao.getAccounts(selectedUserId),
    ];

    // TODO getSelectedAccountId and select it

    final result = await Future.wait(futures);
    final user = result[0] as User;
    final accounts = List<Account>.from(result[1] as Iterable);
    if (user == null || user.token.isEmpty) return null;
    if (accounts.isEmpty) return null;
    final account = accounts.firstWhere(
      (item) => item.localId == selectedAccountId,
      orElse: () => accounts.first,
    );

    // else
    return InitializerResponse(user, account, accounts);
  }

  Future<void> selectUser(int userLocalId) async {
    return _authLocal.setSelectedUserLocalId(userLocalId);
  }

  // returns null the host field needs to be revealed because auto discover was unsuccessful
  Future<User> login({
    @required String email,
    @required String password,
    @required String host,
  }) async {
    // auto discover domain
    String hostname = host;
    if (hostname.isEmpty) {
      if (email == await lastEmail) {
        hostname = (await lastHost) ?? "";
      }
    }
    if (hostname.isEmpty) {
      final autoDiscoveredHost = await _authApi.autoDiscoverHostname(email);
      if (autoDiscoveredHost == null || autoDiscoveredHost.isEmpty) {
        return null;
      } else {
        hostname = autoDiscoveredHost;
      }
    }

    // hostname is implied not to be empty
    hostname = hostname.startsWith("http") ? hostname : "https://$hostname";

    final newUser = await _authApi.login(email, password, hostname);

    return newUser;
  }

  Future<User> setUser(User user) async {
    User userToReturn = await _usersDao.getUserByEmail(user.emailFromLogin);


      await _usersDao.addUser(user);
      userToReturn = await _usersDao.getUserByEmail(user.emailFromLogin);
    selectUser(userToReturn.localId);
    _authLocal.setLastEmail(user.emailFromLogin);
    _authLocal.setLastHost(user.hostname);
    return userToReturn;
  }

  Future<String> get lastEmail => _authLocal.getLastEmail();

  Future<String> get lastHost => _authLocal.getLastHost();

  Future<List<User>> get users => _usersDao.getUsers();

  Future<List<Account>> getAccounts(User user) async {
    final accounts = (await _authApi.getAccounts(user)).toSet();
    // ignore unique constraint errors from the db
    try {
      final localAccounts = await _accountsDao.getAccounts(user.localId);
      for (var local in localAccounts) {
        final server = accounts.firstWhere(
            (element) => element.serverId == local.serverId,
            orElse: () => null);
        if (server == null) {
          await _accountsDao.deleteAccountById(local.localId);
        } else {
          await _accountsDao.updateAccount(server, local.localId);
        }
        accounts.remove(server);
      }
      await _accountsDao.addAccounts(accounts.toList());
      final accountsWithLocalIds = await _accountsDao.getAccounts(user.localId);
      await _authLocal.setSelectedAccountId(accountsWithLocalIds[0].localId);
    } catch (err) {}
    return _accountsDao.getAccounts(user.localId);
  }

  Future<void> logout(int currentUserId, User user) async {
    _authApi.logout(user);

    final futures = [
      deleteUserRelatedData(user),
      if (_cryptoStorage != null && user.localId == currentUserId)
        _cryptoStorage.deleteAll(),
      _authLocal.deleteSelectedUserLocalId(),
      if (user.localId == currentUserId) _authLocal.deleteSelectedAccountId(),
      _usersDao.deleteUser(user.localId),
      _accountsDao.deleteAccountsOfUser(user.localId),
    ];

    await Future.wait(futures);
  }

  Future<void> deleteUserRelatedData(User user) async {
    final mailDao = new MailDao(DBInstances.appDB);
    final foldersDao = new FoldersDao(DBInstances.appDB);
    final contactsDao = new ContactsDao(DBInstances.appDB);
    final contactsStoragesDao = new ContactsStoragesDao(DBInstances.appDB);
    final contactsGroupsDao = new ContactsGroupsDao(DBInstances.appDB);

    final futures = [
      _accountsDao.deleteAccountsOfUser(user.localId),
      foldersDao.deleteFoldersOfUser(user.localId),
      mailDao.deleteMessagesOfUser(user.localId),
      contactsDao.deleteContactsOfUser(user.localId),
      contactsStoragesDao.deleteStoragesOfUser(user.localId),
      contactsGroupsDao.deleteGroupsOfUser(user.localId),
    ];

    await Future.wait(futures);
  }

  Future<User> invalidateToken(int userLocalId) async {
    try {
      await _usersDao.updateUser(userLocalId, UsersCompanion(token: Value("")));
    } catch (e) {
      print(e);
    }
    return _usersDao.getUserByLocalId(userLocalId);
  }

  Future selectAccount(Account account) {
    return _authLocal.setSelectedAccountId(account.localId);
  }

  Future<void> updateAliases(User user, Account account) async {
    try {
      final identities = await _authApi.getAliases(user);
      await _aliasesDao.deleteByUser(user.serverId);
      await _aliasesDao.set(identities);
    } catch (e, s) {
      print(e);
    }
  }

  Future<List<AccountIdentity>> updateIdentity(
      User user, Account account, List<Account> accounts) async {
    try {
      final identities = await _authApi.getIdentity(user);

      final accountsIdentity = accounts.map((item) {
        final identity = AccountIdentity(
          email: item.email,
          useSignature: item.useSignature,
          idUser: item.idUser,
          isDefault: true,
          idAccount: item.accountId,
          friendlyName: item.friendlyName,
          signature: item.signature,
          entityId: item.entityId,
        );

        return identity;
      });
      identities.addAll(accountsIdentity);

      await _accountIdentityDao.deleteByUser(user.serverId);
      await _accountIdentityDao.set(identities);
      return identities;
    } catch (e, s) {
      print(s);
      print(e);
      return await getAccountIdentities(user, account);
    }
  }

  AccountIdentity getDefaultIdentity(
      Account account, List<AccountIdentity> identities) {
    return identities.firstWhere(
      (item) => item.isDefault && item.entityId == account.entityId,
      orElse: () => AccountIdentity(
        email: account.email,
        useSignature: account.useSignature,
        idUser: account.idUser,
        isDefault: true,
        idAccount: account.accountId,
        friendlyName: account.friendlyName,
        signature: account.signature,
        entityId: account.serverId,
      ),
    );
  }

  Future<List<AccountIdentity>> getAccountIdentities(
    User currentUser,
    Account currentAccount,
  ) {
    return _accountIdentityDao.getByUserAndAccount(
      currentUser.serverId,
      currentAccount?.entityId,
    );
  }

  Future<List<Aliases>> getAccountAliases(
    User currentUser,
    Account currentAccount,
  ) {
    return _aliasesDao.getByUserAndAccount(
      currentUser.serverId,
      currentAccount?.entityId,
    );
  }

  Future setFbToken(List<User> users) async {
    if (!BuildProperty.pushNotification) return;
    try {
      final uid = await PushNotificationsManager.instance.deviceId;
      final fbToken = await PushNotificationsManager.instance.getToken();
      final userWithAccount = <User, List<String>>{};
      for (var user in users) {
        final accounts = await _accountsDao.getAccounts(user.localId);
        final emails = <String>{};

        for (var account in accounts) {
          final identities = await _accountIdentityDao.getByUserAndAccount(
              user.localId, account.localId);
          final aliases = await _aliasesDao.getByUserAndAccount(
              user.localId, account.localId);
          emails.add(account.email);
          emails.addAll(identities.map((item) => item.email));
          emails.addAll(aliases.map((item) => item.email));
        }
        emails.add(user.emailFromLogin);
        userWithAccount[user] = emails.toList();
      }
      final success =
          await _authApi.setPushToken(userWithAccount, uid, fbToken);

      PushNotificationsManager.instance.setTokenStatus(success);
    } catch (e) {
      print(e);
    }
  }
}

class InitializerResponse {
  final User user;
  final Account account;
  final List<Account> accounts;

  InitializerResponse(
    this.user,
    this.account,
    this.accounts,
  );
}
