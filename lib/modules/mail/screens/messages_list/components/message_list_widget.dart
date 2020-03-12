//import 'dart:async';
//
//import 'package:aurora_mail/database/app_database.dart';
//import 'package:aurora_mail/utils/internationalization.dart';
//import 'package:aurora_ui_kit/components/am_empty_list.dart';
//import 'package:flutter/material.dart';
//
//class MessageListWidget extends StatefulWidget {
//  final Widget Function(Message, List<Message>) builder;
//  final Stream<List<Message>> Function(int offset) fetch;
//  final bool showThread;
//  final bool isLoading;
//
//  const MessageListWidget({
//    Key key,
//    this.fetch,
//    this.showThread,
//    this.builder,
//    this.isLoading,
//  }) : super(key: key);
//
//  @override
//  _MessageListWidgetState createState() => _MessageListWidgetState();
//}
//
//class _MessageListWidgetState extends State<MessageListWidget> {
//  StreamSubscription subscription;
//  Map<int, List<Message>> threads = {};
//  List<Message> messages = [];
//  int currentOffset = 0;
//  bool isProgress = false;
//  bool firstProgress = true;
//  bool isEnd = false;
//
//  @override
//  void initState() {
//    super.initState();
//
//    init();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  listen() {
//    widget.fetch()
//  }
//
//  checkUpdate() {
//    if (isEnd) {
//      isEnd = false;
//      isProgress = false;
//      _load();
//    }
//  }
//
//  init() {
//    threads = {};
//    messages = [];
//    currentOffset = 0;
//    isProgress = false;
//    firstProgress = true;
//    isEnd = false;
//    if (mounted) setState(() {});
//    _load();
//  }
//
//  _load() async {
//    if (isProgress) return;
//    isProgress = true;
//    if (widget.fetch != null) {
//      final items = await widget.fetch(currentOffset);
//      currentOffset += items.length;
//      isEnd = items.isEmpty;
//      final threadEnable = widget.showThread;
//      for (var item in items) {
//        if (threadEnable && item.parentUid != null) {
//          final thread = threads[item.parentUid] ?? [];
//          thread.add(item);
//          threads[item.parentUid] = thread;
//        } else {
//          messages.add(item);
//        }
//      }
//    } else {
//      isEnd = true;
//    }
//    isProgress = false;
//    firstProgress = false;
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (firstProgress || (widget.isLoading && messages.isEmpty)) {
//      return Center(
//        child: CircularProgressIndicator(),
//      );
//    }
//    if (messages.isEmpty) {
//      return AMEmptyList(message: i18n(context, "messages_empty"));
//    }
//    return ListView.builder(
//      padding: EdgeInsets.only(top: 6.0, bottom: 82.0),
//      itemCount: messages.length + (isEnd && !widget.isLoading ? 0 : 1),
//      itemBuilder: (context, i) {
//        if (i >= messages.length) {
//          if (!isEnd) {
//            _load();
//          }
//          return Center(child: CircularProgressIndicator());
//        }
//        final message = messages[i];
//        final thread = threads[message.uid] ?? [];
//        return widget.builder(message, thread);
//      },
//    );
//  }
//}