//@dart=2.9
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
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/calendar/calendar_dao.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain_impl/services/db/activity/activity_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_dao.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:drift/drift.dart';
import 'package:aurora_mail/modules/auth/repository/device_id_storage.dart';

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
    @required String manuallyEnteredHost,
  }) async {
    // auto discover domain
    String hostname = manuallyEnteredHost;
    if (hostname.isEmpty) {
      if (email == await lastEmail) {
        hostname = (await lastHost) ?? "";
      }
    }
    final autoDiscoveredHost = await _authApi.autoDiscoverHostname(email);
    if (autoDiscoveredHost != null && autoDiscoveredHost.isNotEmpty) {
      hostname = autoDiscoveredHost;
    }
    //manually entered host has priority
    if (manuallyEnteredHost != null && manuallyEnteredHost.isNotEmpty) {
      hostname = manuallyEnteredHost;
    }
    if (hostname.isEmpty) {
      return null;
    }

    // hostname is implied not to be empty
    hostname = hostname.startsWith("http") ? hostname : "https://$hostname";

    var newUser = await _authApi.login(email, password, hostname);

    newUser = newUser.copyWith(
      syncPeriod: BuildProperty.syncPeriod,
    );
    return newUser;
  }

  Future<User> setUser(User user) async {
    User userToReturn = await _usersDao.getUserByEmail(user.emailFromLogin);
    if (userToReturn != null) {
      await _usersDao.updateUser(
          userToReturn.localId, UsersCompanion(token: Value(user.token)));
    } else {
      await _usersDao.addUser(user);
    }
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
    try {
      await _authApi.logout(user);
    } catch (e) {}
    final futures = [
      deleteUserRelatedData(user),
      if (_cryptoStorage != null && user.localId == currentUserId)
        _cryptoStorage.deleteAll(),
      if (user.localId == currentUserId) _authLocal.deleteSelectedUserLocalId(),
      if (user.localId == currentUserId) _authLocal.deleteSelectedAccountId(),
      _usersDao.deleteUser(user.localId),
      _accountsDao.deleteAccountsOfUser(user.localId),
    ];

    await Future.wait(futures);
  }

  Future<void> deleteUnusedUsersWithData(List<User> users) async {
    for(final user in users){
      try{
        await _usersDao.deleteUser(user.localId);
        await _accountsDao.deleteAccountsOfUser(user.localId);
        await deleteUserRelatedData(user);
      }catch(e){
        print(e);
        continue;
      }
    }
  }

  Future<void> deleteUserRelatedData(User user) async {
    final mailDao = new MailDao(DBInstances.appDB);
    final foldersDao = new FoldersDao(DBInstances.appDB);
    final contactsDao = new ContactsDao(DBInstances.appDB);
    final contactsStoragesDao = new ContactsStoragesDao(DBInstances.appDB);
    final contactsGroupsDao = new ContactsGroupsDao(DBInstances.appDB);

    try {
      final calendarDao = new CalendarDao(DBInstances.appDB);
      final eventDao = new ActivityDao(DBInstances.appDB);
      await _accountsDao.deleteAccountsOfUser(user.localId);
      await foldersDao.deleteFoldersOfUser(user.localId);
      await mailDao.deleteMessagesOfUser(user.localId);
      await contactsDao.deleteContactsOfUser(user.localId);
      await contactsStoragesDao.deleteStoragesOfUser(user.localId);
      await contactsGroupsDao.deleteGroupsOfUser(user.localId);
      await calendarDao.deleteAllCalendars(user.localId);
      await eventDao.deleteAllEvents(user.localId);
    } catch (e, st) {
      print(e);
    }

    // final futures = [
    //   _accountsDao.deleteAccountsOfUser(user.localId),
    //   foldersDao.deleteFoldersOfUser(user.localId),
    //   mailDao.deleteMessagesOfUser(user.localId),
    //   contactsDao.deleteContactsOfUser(user.localId),
    //   contactsStoragesDao.deleteStoragesOfUser(user.localId),
    //   contactsGroupsDao.deleteGroupsOfUser(user.localId),
    //   calendarDao.deleteAllCalendars(user.localId),
    //   eventDao.deleteAllEvents(user.localId),
    // ];
    //
    // await Future.wait(futures);
  }

  Future<User> invalidateToken(int userLocalId) async {
    try {
      await _usersDao.updateUser(userLocalId, UsersCompanion(token: Value("")));
    } catch (e) {
      print(e);
    }
    return _usersDao.getUserByLocalId(userLocalId);
  }

  Future selectAccount(int accountLocalId) {
    return _authLocal.setSelectedAccountId(accountLocalId);
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

  Future setFbToken(List<User> users, [bool setNullToken = false]) async {
    if (!BuildProperty.enablePushNotification) return;
    try {
      final uid = await PushNotificationsManager.instance.deviceId;
      final fbToken = setNullToken
          ? null
          : await PushNotificationsManager.instance.getToken();
      print('setFbToken, fbToken = $fbToken');
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
      if (setNullToken) {
        _authApi.setPushToken(userWithAccount, uid, fbToken);
      } else {
        final success =
            await _authApi.setPushToken(userWithAccount, uid, fbToken);

        PushNotificationsManager.instance.setTokenStatus(success);
      }
    } catch (e) {
      print(e);
    }
  }

  Future selectUserByEmail(String email) async {
    final users = await _usersDao.getUsers();
    for (var user in users) {
      if (user.emailFromLogin == email) {
        await _authLocal.setSelectedUserLocalId(user.localId);
        await _selectAccountByEmail(user.localId, email);
        return;
      }
    }
    for (var user in users) {
      final accounts = await _accountsDao.getAccounts(user.localId);
      for (var account in accounts) {
        if (account.email == email) {
          await _authLocal.setSelectedUserLocalId(user.localId);
          await _authLocal.setSelectedAccountId(account.localId);
          return;
        }
      }
    }
  }

  Future _selectAccountByEmail(int userId, String email) async {
    final accounts = await _accountsDao.getAccounts(userId);
    for (var account in accounts) {
      if (account.email == email) {
        await _authLocal.setSelectedAccountId(account.localId);
        return;
      }
    }
  }

  Future<void> saveDevice(User user) async {
    final deviceId = await DeviceIdStorage.getDeviceId();
    final deviceName = await DeviceIdStorage.getDeviceName();
    try {
      await _authApi.saveDevice(
        deviceId,
        deviceName,
        user.hostname,
        user.token,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<int> getTwoFactorSettings(User user) async {
    try {
      return await _authApi.getTwoFactorSettings(user.hostname);
    } catch (e) {
      return 0;
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
