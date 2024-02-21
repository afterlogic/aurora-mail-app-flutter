import 'dart:async';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/notification/push_notifications_manager.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final _methods = new AuthMethods();

  NotificationsBloc() : super(ProgressState()) {
    add(InitToken());
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is InitToken) yield* _initToken();
    if (event is SendToken) yield* _sendToken();
  }

  Stream<NotificationsState> _initToken() async* {
    final state = await PushNotificationsManager.instance.getTokenStatus();
    yield InitState(state);
  }

  Stream<NotificationsState> _sendToken() async* {
    yield ProgressState();
    try {
      await _methods.setFbToken(await _methods.users);
    } catch (e) {}
    yield* _initToken();
  }
}
