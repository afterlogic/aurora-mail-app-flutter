import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final _expandedUids = new List<int>();

class MessageItem extends StatefulWidget {
  final List<Message> threads;
  final Message message;
  final Function(Message) onItemSelected;
  final Function(Message) onDeleteMessage;

  MessageItem(
      this.message, this.threads, this.onItemSelected, this.onDeleteMessage);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool _showThreads = false;
  List<Message> _children = [];

  @override
  void initState() {
    super.initState();
    _children =
        widget.threads.where((t) => t.parentUid == widget.message.uid).toList();
    setState(() => _showThreads = _expandedUids.contains(widget.message.uid));
  }

  void _toggleThreads() {
    if (_showThreads) {
      _expandedUids.remove(widget.message.uid);
    } else {
      _expandedUids.add(widget.message.uid);
    }
    setState(() => _showThreads = !_showThreads);
  }

  @override
  Widget build(BuildContext context) {
    final hasUnreadChildren =
        _children.where((i) => !i.flagsInJson.contains("\\seen")).isNotEmpty;

    final flags = Mail.getFlags(widget.message.flagsInJson);

    final textStyle = TextStyle(
        fontWeight: flags.contains(MessageFlags.seen)
            ? FontWeight.w400
            : FontWeight.w700);

    return Column(
      children: <Widget>[
        InkWell(
          child: Dismissible(
            key: Key(widget.message.uid.toString()),
            direction: DismissDirection.endToStart,
            // TODO translate
            confirmDismiss: (_) => ConfirmationDialog.show(
                context,
                "Delete message",
                "Are you sure you want to delete ${widget.message.subject}?",
                "Delete"),
            onDismissed: (_) => widget.onDeleteMessage(widget.message),
            background: Container(
              color: Theme.of(context).errorColor,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      right: 16.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: Icon(Icons.delete_outline,
                          color: Colors.white, size: 36.0)),
                ],
              ),
            ),
            child: ListTile(
              onTap: () => widget.onItemSelected(widget.message),
              key: Key(widget.message.uid.toString()),
              title: Text(widget.message.fromToDisplay, style: textStyle),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (_children.isNotEmpty)
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(hasUnreadChildren
                              ? MdiIcons.arrowDownDropCircle
                              : MdiIcons.arrowDownDropCircleOutline),
                          onPressed: _toggleThreads,
                        ),
                      ),
                    if (_children.isNotEmpty) SizedBox(width: 6.0),
                    Flexible(
                      child: Opacity(
                        opacity: widget.message.subject.isEmpty ? 0.44 : 1.0,
                        child: Text(
                          // TODO translate
                          widget.message.subject.isNotEmpty
                              ? widget.message.subject
                              : "No subject",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (widget.message.hasAttachments) Icon(Icons.attachment),
                      SizedBox(width: 6.0),
                      Text(
                        DateFormatting.formatDateFromSeconds(
                            timestamp: widget.message.timeStampInUTC),
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (flags.contains(MessageFlags.answered))
                        Padding(
                          padding: const EdgeInsets.only(left: .0),
                          child: Icon(Icons.reply),
                        ),
                      if (flags.contains(MessageFlags.forwarded))
                        Padding(
                          padding: const EdgeInsets.only(left: .0),
                          child: Icon(MdiIcons.share),
                        ),
                      if (flags.contains(MessageFlags.starred))
                        Padding(
                          padding: const EdgeInsets.only(left: .0),
                          child: Icon(Icons.star, color: Colors.amber),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_children.isNotEmpty && _showThreads)
          ..._children.map((t) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 0.0,
                        indent: 4.0,
                        endIndent: 16.0,
                      ),
                      MessageItem(
                          t, [], widget.onItemSelected, widget.onDeleteMessage),
                    ],
                  ),
                ),
                Positioned(
                  left: 16.0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 4.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            );
          }).toList()
      ],
    );
  }
}
