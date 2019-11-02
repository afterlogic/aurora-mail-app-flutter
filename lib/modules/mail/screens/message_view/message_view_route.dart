import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';

class MessageViewRoute {
  static const name = "${MessagesListRoute.name}/message_view";
}

class MessageViewScreenArgs {
  final List<Message> messages;
  final int initialPage;

  const MessageViewScreenArgs(this.messages, this.initialPage);
}
