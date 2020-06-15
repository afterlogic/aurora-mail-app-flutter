class MessagesListRoute {
  static const name = "messages_list";
}

class MessagesListRouteArg {
  final String search;
  final int messageLocalId;

  MessagesListRouteArg({this.messageLocalId, this.search});
}
