import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'star.dart';

final _expandedUids = new List<int>();

class MessageItem extends StatefulWidget {
  final List<Message> children;
  final Message message;
  final Key key;
  final Function(Message) onItemSelected;
  final Function(Message, bool) onStarMessage;
  final Function(Message) onDeleteMessage;

  MessageItem(
    this.message,
    this.children, {
    this.key,
    @required this.onItemSelected,
    @required this.onDeleteMessage,
    @required this.onStarMessage,
  }) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool _showThreads = false;

  @override
  void initState() {
    super.initState();
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

  void _setStarred(bool isStarred) {
    widget.onStarMessage(widget.message, isStarred);
  }

  @override
  Widget build(BuildContext context) {
    final hasUnreadChildren = widget.children
        .where((i) => !i.flagsInJson.contains("\\seen"))
        .isNotEmpty;

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
            confirmDismiss: (_) => ConfirmationDialog.show(
                context,
                i18n(context, "messages_delete_title"),
                i18n(context, "messages_delete_desc_with_subject",
                    {"subject": widget.message.subject}),
                i18n(context, "btn_delete")),
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
              onTap: widget.children.isNotEmpty && !_showThreads
                  ? _toggleThreads
                  : () => widget.onItemSelected(widget.message),
              key: Key(widget.message.uid.toString()),
              title: Text(widget.message.fromToDisplay, style: textStyle),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (widget.children.isNotEmpty)
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: _showThreads ? Icon(hasUnreadChildren
                              ? MdiIcons.arrowUpDropCircle
                              : MdiIcons.arrowUpDropCircleOutline) : Icon(hasUnreadChildren
                              ? MdiIcons.arrowDownDropCircle
                              : MdiIcons.arrowDownDropCircleOutline),
                          onPressed: _toggleThreads,
                        ),
                      ),
                    if (widget.children.isNotEmpty) SizedBox(width: 6.0),
                    Flexible(
                      child: Opacity(
                        opacity: widget.message.subject.isEmpty ? 0.44 : 1.0,
                        child: Text(
                          widget.message.subject.isNotEmpty
                              ? widget.message.subject
                              : i18n(context, "messages_no_subject"),
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
                          widget.message.timeStampInUTC,
                          Localizations.localeOf(context).languageCode,
                        ),
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
                      SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: BlocBuilder<SettingsBloc, SettingsState>(
                            builder: (_, state) => Star(
                              value: widget.message.flagsInJson
                                  .contains("\\flagged"),
                              enabled: !(state is SettingsLoaded &&
                                  state.connection == ConnectivityResult.none),
                              onPressed: _setStarred,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.children.isNotEmpty && _showThreads)
          ...widget.children.map((t) {
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
                      MessageItem(t, [],
                          key: Key(t.localId.toString()),
                          onItemSelected: widget.onItemSelected,
                          onStarMessage: widget.onStarMessage,
                          onDeleteMessage: widget.onDeleteMessage),
                    ],
                  ),
                ),
                Positioned(
                  left: 16.0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 4.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            );
          }).toList()
      ],
    );
  }
}
