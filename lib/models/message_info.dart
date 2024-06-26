import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MessageInfo {
  final int uid;
  final int? parentUid;
  final List<String> flags;
  final bool hasThread;

  MessageInfo({
    required this.uid,
    this.parentUid,
    required this.flags,
    required this.hasThread,
  });

  // for writing to DB
  static String? toJsonString(List<MessageInfo>? items) {
    if (items == null) return null;
    final List mappedItems = items.map((item) {
      return json.encode({
        "uid": item.uid,
        "parentUid": item.parentUid,
        "flags": item.flags,
        "hasThread": item.hasThread,
      });
    }).toList();
    assert(mappedItems.length == items.length);
    return json.encode(mappedItems);
  }

  // for retrieving from DB
  static List<MessageInfo>? fromJsonString(String? rawItems) {
    if (rawItems == null) return null;
    final items = List<String>.from(json.decode(rawItems) as Iterable);
    return items.map((rawItem) {
      final item = json.decode(rawItem);
      return new MessageInfo(
        uid: item["uid"] as int,
        parentUid: item["parentUid"] as int,
        flags: new List<String>.from(item["flags"] as Iterable),
        hasThread: item["hasThread"] as bool,
      );
    }).toList();
  }

  // for flattening nested array from server
  static List<MessageInfo>? flattenMessagesInfo(String? messagesInfoRaw) {
    if (messagesInfoRaw == null) return null;

    final messagesInfo = List.from(json.decode(messagesInfoRaw) as Iterable);

    final flatList = <MessageInfo>[];

    void addItems(List messagesInfo, [int? parentUid]) {
      messagesInfo.forEach((info) {
        final uid = info["uid"] is String
            ? int.parse(info["uid"] as String)
            : info["uid"];
        flatList.add(new MessageInfo(
          uid: uid as int,
          parentUid: parentUid,
          flags: new List<String>.from(info["flags"] as Iterable? ?? []),
          hasThread: info["thread"] != null,
        ));

        if (info["thread"] != null) {
          final thread = List.from(info["thread"] as Iterable);
          addItems(thread, uid);
        }
      });
    }

    addItems(messagesInfo);
    flatList.sort((a, b) => b.uid.compareTo(a.uid));
    return flatList;
  }
}
