//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'backup_code_event.dart';
import 'backup_code_methods.dart';
import 'backup_code_state.dart';

class BackupCodeBloc extends Bloc<BackupCodeEvent, BackupCodeState> {
  final _methods = BackupCodeMethods();

  BackupCodeBloc() : super(InitialState());

  @override
  Stream<BackupCodeState> mapEventToState(
    BackupCodeEvent event,
  ) async* {
    if (event is Verify) yield* _logIn(event);
  }

  Stream<BackupCodeState> _logIn(Verify state) async* {
    yield ProgressState();

    try {
      final user = await _methods.verifyCode(
        state.pin,
        state.host,
        state.login,
        state.pass,
      );
      yield CompleteState(user);
    } catch (err, s) {
      if (err is InvalidPin) {
        yield ErrorState(ErrorToShow.message(S.current.tfa_error_invalid_backup_code));
      } else {
        yield ErrorState(formatError(err, s));
      }
    }
  }
}
