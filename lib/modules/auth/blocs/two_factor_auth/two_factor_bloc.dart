import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'two_factor_event.dart';
import 'two_factor_methods.dart';
import 'two_factor_state.dart';

class TwoFactorBloc extends Bloc<TwoFactorEvent, TwoFactorState> {
  final _methods = TwoFactorMethods();

  @override
  TwoFactorState get initialState => InitialState();

  @override
  Stream<TwoFactorState> mapEventToState(
    TwoFactorEvent event,
  ) async* {
    if (event is LogIn) yield* _logIn(event);
  }

  Stream<TwoFactorState> _logIn(LogIn state) async* {
    yield ProgressState();

    try {
      final user = await _methods.verifyPin(
        state.pin,
        state.host,
        state.login,
        state.pass,
      );
      yield CompleteState(user);
    } catch (err, s) {
      if (err is InvalidPin) {
        yield ErrorState("invalid_pin");
      } else {
        yield ErrorState(formatError(err, s));
      }
    }
  }
}
