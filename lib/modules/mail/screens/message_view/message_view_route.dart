
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';

class MessageViewRoute {
  static const name = "message_view";
}

class MessageViewScreenArgs {
  final Message message;
  final MailBloc? mailBloc;
  final ContactsBloc? contactsBloc;
  final MessagesListBloc? messagesListBloc;

  const MessageViewScreenArgs({
    required this.message,
    required this.mailBloc,
    required this.messagesListBloc,
    required this.contactsBloc,
  });
}

class MessageProgressRoute {
  static const name = "MessageProgressRoute";
}

class MessageProgressRouteArg {
  final Future<Message?> futureMessage;
  final MailBloc? mailBloc;
  final ContactsBloc? contactsBloc;
  final MessagesListBloc? messagesListBloc;

  const MessageProgressRouteArg({
    required this.futureMessage,
    required this.mailBloc,
    required this.messagesListBloc,
    required this.contactsBloc,
  });
}
