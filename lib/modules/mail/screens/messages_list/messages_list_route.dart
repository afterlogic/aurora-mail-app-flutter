class MessagesListRoute {
  static const name = "messages_list";
}

class MessagesListRouteArg {
  final String search;
  final int messageUid;

  MessagesListRouteArg({this.messageUid, this.search});
}
