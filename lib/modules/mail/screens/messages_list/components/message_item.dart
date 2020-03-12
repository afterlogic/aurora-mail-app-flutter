import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
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
  final bool isSent;
  final Function(Message) onItemSelected;
  final Function(Message, bool) onStarMessage;
  final Function(Message) onDeleteMessage;

  const MessageItem(
    this.isSent,
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

class _MessageItemState extends BState<MessageItem> {
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

  String _getEmailTitle() {
    final m = widget.message;
    if (widget.isSent) {
      if (m.toToDisplay == "messages_unknown_recipient") {
        return i18n(context, "messages_unknown_recipient");
      } else {
        return m.toToDisplay;
      }
    } else {
      if (m.fromToDisplay == "messages_unknown_sender") {
        return i18n(context, "messages_unknown_sender");
      } else {
        return m.fromToDisplay;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.message;
    final hasUnreadChildren = widget.children
        .where((i) => !i.flagsInJson.contains("\\seen"))
        .isNotEmpty;

    final flags = Mail.getFlags(m.flagsInJson);

    final fontWeight =
        flags.contains(MessageFlags.seen) ? FontWeight.w400 : FontWeight.w700;

    Widget _buildThreadCounter(BuildContext context, bool hasUnread) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: hasUnread ? theme.accentColor : null,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: theme.accentColor, width: 2.0),
        ),
        child: Text(
          widget.children.length.toString(),
          style: TextStyle(color: hasUnread ? Colors.white : theme.accentColor),
        ),
      );
    }

    return Column(
      children: <Widget>[
        InkWell(
          child: Dismissible(
            key: Key(m.uid.toString()),
            direction: DismissDirection.endToStart,
            confirmDismiss: (_) => ConfirmationDialog.show(
              context,
              i18n(context, "messages_delete_title"),
              i18n(context, "messages_delete_desc_with_subject",
                  {"subject": m.subject}),
              i18n(context, "btn_delete"),
              destructibleAction: true,
            ),
            onDismissed: (_) => widget.onDeleteMessage(m),
            background: Container(
              color: theme.errorColor,
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
                  : () => widget.onItemSelected(m),
              key: Key(m.uid.toString()),
              title: Text(_getEmailTitle(),
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: 14.0,
                    color: theme.disabledColor,
                  )),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (widget.children.isNotEmpty)
                      InkResponse(
                        child: _buildThreadCounter(context, hasUnreadChildren),
                        onTap: _toggleThreads,
                      ),
                    if (widget.children.isNotEmpty) SizedBox(width: 6.0),
                    Flexible(
                      child: Opacity(
                        opacity: m.subject.isEmpty ? 0.44 : 1.0,
                        child: Text(
                          m.subject.isNotEmpty
                              ? m.subject
                              : i18n(context, "messages_no_subject"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: fontWeight,
                            fontSize: 16.0,
                            color: theme.textTheme.title.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (m.hasAttachments) Icon(Icons.attachment),
                      SizedBox(width: 6.0),
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (_, state) => Text(
                          DateFormatting.getShortMessageDate(
                            timestamp: m.timeStampInUTC,
                            locale:
                                Localizations.localeOf(context).languageCode,
                            yesterdayWord:
                                i18n(context, "formatting_yesterday"),
                            is24: (state as SettingsLoaded).is24 ?? true,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: theme.disabledColor
                                .withAlpha(theme.disabledColor.alpha ~/ 2),
                          ),
                        ),
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
                              value: m.flagsInJson.contains("\\flagged"),
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
        Divider(
          indent: 16.0,
          endIndent: 16.0,
          height: 0.0,
          color: theme.disabledColor.withOpacity(0.08),
        ),
        if (widget.children.isNotEmpty && _showThreads)
          ...widget.children.map((t) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: <Widget>[
//                      Divider(
//                        height: 0.0,
//                        indent: 4.0,
//                        endIndent: 16.0,
//                      ),
                      MessageItem(widget.isSent, t, [],
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
                    color: theme.accentColor,
                  ),
                ),
              ],
            );
          }).toList()
      ],
    );
  }
}
