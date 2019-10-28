import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MessageInfo {
  final int uid;
  final int parentUid;
  final List<String> flags;
  final bool hasThread;
  bool hasBody;

  MessageInfo({
    @required this.uid,
    this.parentUid,
    @required this.flags,
    this.hasBody = false,
    @required this.hasThread,
  });

  // for writing to DB
  static String toJsonString(List<MessageInfo> items) {
    if (items == null) return null;
    final List mappedItems = items.map((item) {
      return json.encode({
        "uid": item.uid,
        "parentUid": item.parentUid,
        "flags": item.flags,
        "hasThread": item.hasThread,
        "hasBody": item.hasBody,
      });
    }).toList();
    assert(mappedItems.length == items.length);
    return json.encode(mappedItems);
  }

  // for retrieving from DB
  static List<MessageInfo> fromJsonString(String rawItems) {
    if (rawItems == null) return null;
    final List items = json.decode(rawItems);
    return items.map((rawItem) {
      final item = json.decode(rawItem);
      return new MessageInfo(
        uid: item["uid"],
        parentUid: item["parentUid"],
        flags: new List<String>.from(item["flags"]),
        hasThread: item["hasThread"],
        hasBody: item["hasBody"],
      );
    }).toList();
  }

  // for flattening nested array from server
  static List<MessageInfo> flattenMessagesInfo(String messagesInfoRaw) {
    if (messagesInfoRaw == null) return null;

    final messagesInfo = json.decode(messagesInfoRaw);

    final flatList = new List<MessageInfo>();

    void addItems(List messagesInfo, [int parentUid]) {
      messagesInfo.forEach((info) {
        flatList.add(new MessageInfo(
          uid: info["uid"],
          parentUid: parentUid,
          flags: new List<String>.from(info["flags"]),
          hasBody: info["hasBody"] ?? false,
          hasThread: info["thread"] != null,
        ));

        if (info["thread"] != null) {
          addItems(info["thread"], info["uid"]);
        }
      });
    }

    addItems(messagesInfo);
    return flatList;
  }
}
