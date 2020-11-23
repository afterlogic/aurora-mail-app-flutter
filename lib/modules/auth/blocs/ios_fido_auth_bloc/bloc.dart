import 'dart:async';
import 'dart:html';

import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/event.dart';
import 'package:aurora_mail/modules/auth/blocs/ios_fido_auth_bloc/state.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yubico_flutter/yubico_flutter.dart';

class IosFidoAuthBloc extends Bloc<IosFidoAuthEvent, IosFidoAuthState> {
  final String host;
  final String login;
  final String password;
  final AuthBloc authBloc;
  final authApi = AuthApi();

  IosFidoAuthBloc(this.host, this.login, this.password, this.authBloc);

  @override
  IosFidoAuthState get initialState => InitState();

  @override
  Stream<IosFidoAuthState> mapEventToState(IosFidoAuthEvent event) async* {
    if (event is StartAuth) {
      yield* _startAuth(event);
    } else if (event is SendToKey) {
      yield* _sendToKey(event);
    }
  }

  Stream<IosFidoAuthState> _startAuth(StartAuth event) async* {
    try {
      yield SendingBeginAuthRequestState();
      final request =
          await authApi.verifySecurityKeyBegin(host, login, password);
      if (YubicoFlutter.instance.keyState == KeyState.OPEN) {
        add(SendToKey(request));
      } else {
        yield WaitKeyState();
        StreamSubscription sub;
        sub = YubicoFlutter.instance.onState.listen((event) {
          if (event == KeyState.OPEN) {
            sub.cancel();
            add(SendToKey(request));
          }
        });
      }
    } catch (e) {
      yield ErrorState(ErrorToShow(e));
    }
  }

  Stream<IosFidoAuthState> _sendToKey(SendToKey event) async* {
    try {
      final domainUrl = Uri.parse(event.request.host).host;
      yield TouchKeyState();
      final keyResponse = await YubicoFlutter.instance.authRequest(
        domainUrl,
        event.request.timeout,
        event.request.challenge,
        null,
        event.request.rpId,
        event.request.allowCredentials,
      );
      yield SendingFinishAuthRequestState();
      final loginResponse = await authApi.verifySecurityKeyFinish(
        host,
        login,
        password,
        keyResponse["attestation"] as Map,
      );
      authBloc.add(UserLogIn(loginResponse));
    } catch (e) {
      yield ErrorState(ErrorToShow(e));
    }
  }
}
