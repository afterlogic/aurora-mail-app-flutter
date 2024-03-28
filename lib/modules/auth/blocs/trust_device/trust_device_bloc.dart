//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'trust_device_event.dart';
import 'trust_device_methods.dart';
import 'trust_device_state.dart';

class TrustDeviceBloc extends Bloc<TrustDeviceEvent, TrustDeviceState> {
  final _methods = TrustDeviceMethods();
  final User user;
  final AuthBloc authBloc;

  TrustDeviceBloc(this.user, this.authBloc) : super(InitialState());

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
        await _methods.trustDevice(user);
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
