import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter/material.dart';

class StreamPaginationList extends StatefulWidget {
  final Widget Function(BuildContext, Message, List<Message>) builder;
  final Widget Function(BuildContext, dynamic e) onError;
  final Stream<List<Message>> Function(int) fetch;
  final Widget Function(BuildContext) empty;
  final Widget progress;

  const StreamPaginationList({
    this.builder,
    this.fetch,
    this.progress,
    this.onError,
    this.empty,
    Key key,
  }) : super(key: key);

  @override
  _StreamPaginationListState createState() => _StreamPaginationListState();
}

class _StreamPaginationListState extends State<StreamPaginationList> {
  Map<int, _ListPart> parts = {0: _ListPart()};

  @override
  Widget build(BuildContext context) {
    if (parts[0].items?.isEmpty == true) {
      return widget.empty(context);
    }

    final threads = <Message>[];
    for (var part in parts.values) {
      if (part?.items != null) {
        threads.addAll(part.threads);
      }
    }

    return ListView.builder(
      itemCount: parts.length,
      itemBuilder: (context, id) {
        return _ListPartWidget(
          id,
          parts[id],
          widget.fetch,
          (context, item) => widget.builder(context, item, threads),
          onInit,
          widget.progress,
          widget.onError,
        );
      },
    );
  }

  onInit(int id, bool hasMore) {
    if (hasMore) {
      if (!parts.containsKey(id + 1)) {
        parts[id + 1] = _ListPart();
      }
    }
    setState(() {});
  }
}

class _ListPartWidget extends StatefulWidget {
  final int id;
  final _ListPart part;
  final Stream<List<Message>> Function(int) fetch;
  final Widget Function(BuildContext, Message) builder;
  final Widget Function(BuildContext, dynamic e) onError;
  final Function(int, bool) onInit;
  final Widget progress;

  _ListPartWidget(
    this.id,
    this.part,
    this.fetch,
    this.builder,
    this.onInit,
    this.progress,
    this.onError,
  );

  @override
  _ListPartWidgetState createState() => _ListPartWidgetState();
}

class _ListPartWidgetState extends State<_ListPartWidget> {
  bool disposed = true;
  bool isInit = false;
  var error;
  StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return widget.onError(context, error);
    }
    if (widget.part.items != null) {
      final messages = widget.part.messages;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children:
            messages.map((item) => widget.builder(context, item)).toList(),
      );
    } else if (widget.part.size != null) {
      return SizedBox.fromSize(size: widget.part.size);
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.progress,
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;

    clear();
  }

  @override
  void initState() {
    super.initState();
    disposed = false;

    load();
  }

  load() async {
    isInit = false;
    error = null;
    subscription = widget.fetch(widget.id).listen((items) {
      error = null;
      if (!isInit) {
        if (items.isNotEmpty) {
          isInit = true;
          widget.onInit(widget.id, true);
        } else if (widget.id == 0 && items.isEmpty) {
          widget.onInit(widget.id, false);
        }
      }
      widget.part.items = items;
      if (mounted) setState(() {});
    }, onError: (e) {
      error = e;
      if (mounted) setState(() {});
    });
  }

  clear() {
    subscription?.cancel();
    subscription = null;
    try {
      widget.part.size = (context.findRenderObject() as RenderBox).size;
    } catch (e) {}
    widget.part.items = null;
  }
}

class _ListPart {
  Size size;
  List<Message> _items;
  List<Message> _messages;

  List<Message> _threads;

  List<Message> get items => _items;

  set items(List<Message> value) {
    _items = value;
    if (value == null) {
      _messages = null;
      _threads = null;
      return;
    }
    _messages = [];
    _threads = [];
    value.forEach((item) {
      if (item.parentUid == null) {
        _messages.add(item);
      } else {
        _threads.add(item);
      }
    });
  }

  List<Message> get messages => _messages;

  List<Message> get threads => _threads;
}
