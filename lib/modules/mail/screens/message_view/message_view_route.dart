import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';

class MessageViewRoute {
  static const name = "${MessagesListRoute.name}/message_view";
}

class MessageViewScreenArgs {
  final List<Message> messages;
  final int initialPage;
  final MailBloc mailBloc;
  final MessagesListBloc messagesListBloc;

  const MessageViewScreenArgs(
      this.messages, this.initialPage, this.mailBloc, this.messagesListBloc);
}
