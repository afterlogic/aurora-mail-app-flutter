import 'dart:async';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/event.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/state.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yubico_flutter/yubico_flutter.dart';

class IosFidoAuthBloc extends Bloc<IosFidoAuthEvent, IosFidoAuthState> {
  final String host;
  final String login;
  final String password;
  final AuthBloc authBloc;
  final authApi = AuthApi();
  FidoAuthRequest fidoRequest;

  IosFidoAuthBloc(this.host, this.login, this.password, this.authBloc);

  @override
  IosFidoAuthState get initialState => InitState();

  @override
  Stream<IosFidoAuthState> mapEventToState(IosFidoAuthEvent event) async* {
    if (event is StartAuth) {
      yield* _startAuth(event);
    } else if (event is KeyResult) {
      yield* _keyResult(event);
    } else if (event is CancelByUser) {
      yield* _cancelByUser(event);
    }
  }

  Stream<IosFidoAuthState> _cancelByUser(CancelByUser event) async* {
    fidoRequest?.close();
    fidoRequest = null;
    yield ErrorState(null);
  }

  Stream<IosFidoAuthState> _keyResult(KeyResult event) async* {
    try {
      fidoRequest.close();
      final waitSheet = Completer();

      yield SendingFinishAuthRequestState(waitSheet);
      if (!fidoRequest.isNFC) {
        await waitSheet.future;
      }
      final loginResponse = await authApi.verifySecurityKeyFinish(
        host,
        login,
        password,
        event.result["attestation"] as Map,
      );
      authBloc.add(UserLogIn(loginResponse));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message == "No valid credentials provided.") {
          yield ErrorState(ErrorToShow.code(S.fido_error_invalid_key));
          return;
        }
      }
      if (e is CanceledByUser) {
        yield ErrorState(null);
        return;
      }
      yield ErrorState(ErrorToShow(e));
    }
  }

  Stream<IosFidoAuthState> _startAuth(StartAuth event) async* {
    try {
      yield SendingBeginAuthRequestState();
      final request = await authApi.verifySecurityKeyBegin(host, login, password);
      yield WaitKeyState();
      final domainUrl = Uri.parse(request.host).origin;
      fidoRequest = FidoAuthRequest(
        Duration(seconds: 30),
        domainUrl,
        request.timeout,
        request.challenge,
        null,
        request.rpId,
        request.allowCredentials,
      );
      final isNFC = await fidoRequest.waitConnection(event.message, event.success);

      if (!isNFC) {
        yield TouchKeyState();
      }
      fidoRequest.start().then((value) => add(KeyResult(value)));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message == "No valid credentials provided.") {
          yield ErrorState(ErrorToShow.code(S.fido_error_invalid_key));
          return;
        }
      }
      if (e is CanceledByUser) {
        yield ErrorState(null);
        return;
      }
      yield ErrorState(ErrorToShow(e));
    }
  }
}
