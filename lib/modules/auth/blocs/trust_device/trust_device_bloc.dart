import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'trust_device_event.dart';
import 'trust_device_methods.dart';
import 'trust_device_state.dart';

class TrustDeviceBloc extends Bloc<TrustDeviceEvent, TrustDeviceState> {
  final _methods = TrustDeviceMethods();
  final User user;
  final String login;
  final String password;
  final AuthBloc authBloc;

  TrustDeviceBloc(this.login, this.password, this.user, this.authBloc);

  @override
  TrustDeviceState get initialState => InitialState();

  @override
  Stream<TrustDeviceState> mapEventToState(
    TrustDeviceEvent event,
  ) async* {
    if (event is TrustThisDevice) yield* _trustThisDevice(event);
  }

  Stream<TrustDeviceState> _trustThisDevice(TrustThisDevice state) async* {
    yield ProgressState();

    try {
      if (state.trust) {
        await _methods.trustDevice(login, password, user);
      }
      final completer = Completer();
      await authBloc.add(UserLogInFinish(user, completer));
      await completer.future;
      yield CompleteState();
    } catch (err, s) {
      yield ErrorState(formatError(err, s));
    }
  }
}
