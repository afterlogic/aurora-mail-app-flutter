import 'dart:async';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:webmail_api_client/webmail_api_error.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _methods = new AuthMethods();

  Account currentAccount;

//  static String hostName;
  List<Account> accounts = [];
  AccountIdentity currentIdentity;
  User currentUser;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitUserAndAccounts) yield* _initUserAndAccounts(event);
    if (event is GetLastEmail) yield* _getLastEmail(event);
    if (event is LogIn) yield* _login(event);
    if (event is SelectUser) yield* _selectUser(event);
    if (event is DeleteUser) yield* _deleteUser(event);
    if (event is InvalidateCurrentUserToken)
      yield* _invalidateCurrentUserToken(event);
    if (event is ChangeAccount) yield* _changeAccount(event);
    if (event is UserLogIn) yield* _userLogIn(event);
  }

  Stream<AuthState> _initUserAndAccounts(InitUserAndAccounts event) async* {
    final result = await _methods.getUserAndAccountsFromDB();
    final users = await _methods.users;

    try {
      if (result != null) {
        accounts = result.accounts;
        currentUser = result.user;
        currentAccount = result.account;

        _methods.setFbToken(users);

        final identities =
            await _methods.getAccountIdentities(currentUser, currentAccount);
        currentIdentity = identities.firstWhere((item) => item.isDefault,
                orElse: () => null) ??
            AccountIdentity(
              email: currentAccount.email,
              useSignature: currentAccount.useSignature,
              idUser: currentAccount.idUser,
              isDefault: true,
              idAccount: currentAccount.accountId,
              friendlyName: currentAccount.friendlyName,
              signature: currentAccount.signature,
              entityId: currentAccount.serverId,
            );

        yield InitializedUserAndAccounts(
          user: currentUser,
          users: users,
          needsLogin: false,
          account: currentAccount,
          accounts: result.accounts,
          identity: currentIdentity,
        );
      } else {
        yield InitializedUserAndAccounts(
          user: null,
          users: null,
          needsLogin: true,
          account: null,
          accounts: null,
        );
      }
    } catch (err, s) {
      print("_initUserAndAccounts err: $err");
      print("_initUserAndAccounts s: $s");
      yield InitializedUserAndAccounts(
        user: null,
        users: null,
        needsLogin: true,
        account: null,
        accounts: null,
      );
    }
  }

  Stream<AuthState> _getLastEmail(GetLastEmail event) async* {
    final email = await _methods.lastEmail;
    if (email != null) yield ReceivedLastEmail(email);
  }

  Stream<AuthState> _selectUser(SelectUser event) async* {
    await _methods.selectUser(event.userLocalId);
    yield UserSelected();
    add(InitUserAndAccounts());
  }

  Stream<AuthState> _login(LogIn event) async* {
    yield LoggingIn();
    final users = await _methods.users;
    final userFromDb = users.firstWhere((u) => u.emailFromLogin == event.email,
        orElse: () => null);

    if (userFromDb != null) {
      add(SelectUser(userFromDb.localId));
    } else {
      try {
        final user = await _methods.login(
          email: event.email,
          password: event.password,
          host: event.hostname,
        );

        if (user == null) {
          yield NeedsHost();
        } else {
          yield* _userLogIn(UserLogIn(user));
        }
      } catch (err, s) {
        if (err is RequestTwoFactor) {
          yield TwoFactor(
            event.email,
            event.password,
            err.host,
          );
        } else if (err is WebMailApiError &&
            err.message == "ERROR_USER_MOBILE_ACCESS_LIMIT") {
          yield UpgradePlan(err.message);
        } else {
          yield AuthError(formatError(err, s));
        }
      }
    }
  }

  Stream<AuthState> _userLogIn(UserLogIn event) async* {
    try {
      final user = await _methods.setUser(event.user);
      final users = await _methods.users;
      currentUser = user;
      _methods.setFbToken(users);
      final accounts = await _methods.getAccounts(user);

      if (accounts.isNotEmpty) {
        assert(accounts[0] != null);
        this.accounts = accounts;
        currentAccount = accounts[0];
        await _methods.updateAliases(currentUser, currentAccount);
        currentIdentity = await _methods.updateIdentity(
          currentUser,
          currentAccount,
          accounts,
        );

        yield InitializedUserAndAccounts(
          users: users,
          user: currentUser,
          accounts: accounts,
          account: currentAccount,
          needsLogin: false,
        );
      } else {
        yield AuthError("error_login_no_accounts");
      }
    } catch (e, s) {
      yield AuthError(formatError(e, s));
    }
  }

  Stream<AuthState> _deleteUser(DeleteUser event) async* {
    await AlarmService.removeAlarm(ALARM_ID);
    try {
      await _methods.logout(event.user);
      final users = await _methods.users;

      if (users.isNotEmpty) {
        add(SelectUser(users[0].localId));
      } else {
        yield LoggedOut();
      }
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _invalidateCurrentUserToken(
      InvalidateCurrentUserToken event) async* {
    if (currentUser != null) {
      currentUser = await _methods.invalidateToken(currentUser.localId);
    } else {
      print("cannot invalidate token, no currentUser selected");
    }
  }

  Stream<AuthState> _changeAccount(ChangeAccount event) async* {
    await _methods.selectAccount(event.account);
    add(InitUserAndAccounts());
  }

  Future<List<AccountIdentity>> getIdentities([bool forAllAccount]) {
    return _methods.getAccountIdentities(
      currentUser,
      forAllAccount == true ? null : currentAccount,
    );
  }

  Future<List<Aliases>> getAliases([bool forAllAccount]) {
    return _methods.getAccountAliases(
      currentUser,
      forAllAccount == true ? null : currentAccount,
    );
  }

  Future<List<AliasOrIdentity>> getAliasesAndIdentities(
      [bool forAllAccount]) async {
    final identities = await getIdentities(forAllAccount);
    final aliases = await getAliases(forAllAccount);
    final items = <AliasOrIdentity>[];
    for (var value in identities) {
      items.add(AliasOrIdentity(null, value));
    }
    for (var value in aliases) {
      items.add(AliasOrIdentity(value, null));
    }
    return items;
  }
}
