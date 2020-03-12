import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MessageInfo {
  final String folder;
  final int accountLocalId;
  final int uid;
  int parentUid;
  final List<String> flags;
  bool hasThread;
  bool hasBody;

  MessageInfo({
    this.folder,
    this.accountLocalId,
    @required this.uid,
    this.parentUid,
    @required this.flags,
    this.hasBody = false,
    @required this.hasThread,
  });


  // for flattening nested array from server
  static List<MessageInfo> flattenMessagesInfo(String messagesInfoRaw) {
    if (messagesInfoRaw == null) return null;

    final messagesInfo = List.from(json.decode(messagesInfoRaw) as Iterable);

    final flatList = new List<MessageInfo>();

    void addItems(List messagesInfo, [int parentUid]) {
      messagesInfo.forEach((info) {
        final uid = info["uid"] is String
            ? int.parse(info["uid"] as String)
            : info["uid"];
        flatList.add(new MessageInfo(
          uid: uid as int,
          parentUid: parentUid,
          flags: new List<String>.from(info["flags"] as Iterable ?? []),
          hasBody: info["hasBody"] as bool ?? false,
          hasThread: info["thread"] != null,
        ));

        if (info["thread"] != null) {
          final thread = List.from(info["thread"] as Iterable);
          addItems(thread, uid as int);
        }
      });
    }

    addItems(messagesInfo);
    flatList.sort((a, b) => b.uid.compareTo(a.uid));
    return flatList;
  }
}
