import 'package:aurora_mail/database/app_database.dart';

class MessageViewRoute {
  static const name = "messages_list/message_view";
}

class MessageViewScreenArgs {
  final List<Message> messages;
  final int initialPage;

  const MessageViewScreenArgs(this.messages, this.initialPage);
}
