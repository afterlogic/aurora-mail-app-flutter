//@dart=2.9
import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_methods.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:flutter/material.dart';

class StreamPaginationList extends StatefulWidget {
  final Widget Function(BuildContext, Message, List<Message>) builder;
  final Widget Function(BuildContext, dynamic e) onError;
  final Stream<List<Message>> Function(int) fetch;
  final Widget Function(BuildContext) emptyWidget;
  final Function(int count) onSelect;
  final Widget progressWidget;
  final Widget Function(int) header;
  final String folder;
  final SelectionController selectionController;

  const StreamPaginationList({
    this.builder,
    this.fetch,
    this.progressWidget,
    this.onError,
    this.emptyWidget,
    Key key,
    this.folder,
    this.onSelect,
    this.selectionController,
    this.header,
  }) : super(key: key);

  @override
  _StreamPaginationListState createState() => _StreamPaginationListState();
}

class _StreamPaginationListState extends State<StreamPaginationList> {
  Map<int, _ListPart> parts = {0: _ListPart()};
  bool selectEnable;

  @override
  void initState() {
    super.initState();
    widget.selectionController.addListener(onSelect);
    widget.selectionController.enable = false;
    selectEnable = false;
  }

  @override
  void dispose() {
    super.dispose();
    widget.selectionController.removeListener(onSelect);
    widget.selectionController.enable = false;
  }

  onSelect() {
    if (widget.selectionController.enable != selectEnable) {
      selectEnable = widget.selectionController.enable;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final threads = <Message>[];
    for (var part in parts.values) {
      if (part?.items != null) {
        threads.addAll(part.threads);
      }
    }
    final existHeader = widget.header != null;
    final list = ListView.builder(
      padding: EdgeInsets.only(top: 6.0, bottom: 82.0),
      itemCount: parts.length + (existHeader ? 1 : 0),
      itemBuilder: (context, _id) {
        var id = _id;
        if (existHeader) {
          if (id == 0) {
            return widget.header(parts[0].items?.length);
          }
          id--;
        }
        return _ListPartWidget(
          id,
          parts[id],
          widget.fetch,
          (context, item) => widget.builder(context, item, threads),
          onInit,
          widget.progressWidget,
          widget.onError,
          widget.emptyWidget,
          widget.folder,
          parts.length - 1 == id,
        );
      },
    );
    return list;
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
  final Widget Function(BuildContext) empty;
  final Function(int, bool) onInit;
  final Widget progress;
  final String folder;
  final bool isEnd;

  _ListPartWidget(
    this.id,
    this.part,
    this.fetch,
    this.builder,
    this.onInit,
    this.progress,
    this.onError,
    this.empty,
    this.folder,
    this.isEnd,
  );

  @override
  _ListPartWidgetState createState() => _ListPartWidgetState();
}

class _ListPartWidgetState extends State<_ListPartWidget> {
  bool isInit = false;
  dynamic error;
  StreamSubscription<List<Message>> subscription;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return widget.onError(context, error);
    }
    if (widget.part.items != null) {
      final messages = widget.part.messages;
      if (messages.isEmpty == true) {
        if (widget.id == 0) {
          return widget.empty(context);
        } else if (widget.isEnd &&
            MailMethods.currentFolderUpdate != null &&
            widget.folder == MailMethods.currentFolderUpdate) {
          return widget.progress;
        } else {
          return SizedBox.shrink();
        }
      }
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
      );
    }
  }

  Future<void> _load() async {
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

  void _clear() {
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
