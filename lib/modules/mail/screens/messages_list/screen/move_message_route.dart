import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';

class MoveMessageRoute {
  static const name = "MoveMessageRoute";
}

class MoveMessageRouteArg {
  final List<Message> messages;
  final MessagesListBloc bloc;

  MoveMessageRouteArg(this.messages, this.bloc);
}
