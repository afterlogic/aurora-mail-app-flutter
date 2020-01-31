import 'package:flutter/foundation.dart';

class StatusBarNotification {
  final String packageName;
  final int id;
  final String tag;
  final int postTime;
  final String groupKey;
  final bool isGroup;

  const StatusBarNotification({
    @required this.packageName,
    @required this.id,
    @required this.tag,
    @required this.postTime,
    @required this.groupKey,
    @required this.isGroup,
  });

  factory StatusBarNotification.fromMap(Map map) {
    return new StatusBarNotification(
      packageName: map['packageName'] as String,
      id: map['id'] as int,
      tag: map['tag'] as String,
      postTime: map['postTime'] as int,
      groupKey: map['groupKey'] as String,
      isGroup: map['isGroup'] as bool,
    );
  }

}
