import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/errors_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _methods = new AuthMethods();

  static String _hostName;

  static String get hostName => _hostName;

  static String get apiUrl => "$_hostName/?Api/";

  static Account _currentAccount;

  static Account get currentAccount => _currentAccount;

  static User _currentUser;

  static User get currentUser => _currentUser;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitUserAndAccounts) yield* _initUserAndAccounts(event);
    if (event is LogIn) yield* _login(event);
    if (event is LogOut) yield* _logout(event);
    if (event is UpdateUser) yield* _setUser(event);
  }

  Stream<AuthState> _initUserAndAccounts(InitUserAndAccounts event) async* {
    final result = await _methods.getUserAndAccountsFromDB();

    try {
      if (result != null) {
        _currentUser = result.user;
        _hostName = result.user.hostname;
        _currentAccount = result.accounts[0];
        yield InitializedUserAndAccounts(result.user, needsLogin: false);
      } else {
        yield InitializedUserAndAccounts(null, needsLogin: true);
      }
    } catch (err, s) {
      print("_initUserAndAccounts err: $err");
      print("_initUserAndAccounts s: $s");
      yield InitializedUserAndAccounts(null, needsLogin: true);
    }
  }

  Stream<AuthState> _login(LogIn event) async* {
    yield LoggingIn();

    try {
      final user = await _methods.login(
        email: event.email,
        password: event.password,
        host: event.hostname,
      );

      if (user == null) {
        yield NeedsHost();
      } else {
        _hostName = user.hostname;
        _currentUser = user;
        final accounts = await _methods.getAccounts(user.serverId);

        if (accounts.isNotEmpty) {
          assert(accounts[0] != null);
          _currentAccount = accounts[0];
          yield LoggedIn(user);
        } else {
          yield AuthError(WebMailError.UserHasNoAccounts);
        }
      }
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _logout(LogOut event) async* {
    try {
      await _methods.logout(_currentUser);
      _currentUser = null;
      _currentAccount = null;

      yield LoggedOut();
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _setUser(UpdateUser event) async* {
    _currentUser = event.updatedUser;
  }
}
