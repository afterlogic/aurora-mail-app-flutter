//@dart=2.9
import 'dart:convert';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:collection/collection.dart';
import 'package:connectivity/connectivity.dart';
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
  final bool isNote;
  final Function(Message) onItemSelected;
  final Function(Message, bool) onStarMessage;
  final Function(Message) onDeleteMessage;
  final Function(Message, bool) onUnreadMessage;
  final SelectionController selectionController;

  const MessageItem(
    this.isSent,
    this.message,
    this.children, {
    this.key,
    @required this.onItemSelected,
    @required this.isNote,
    @required this.onDeleteMessage,
    @required this.onStarMessage,
    this.selectionController,
    this.onUnreadMessage,
  }) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends BState<MessageItem> {
  bool _showThreads = false;
  var extendFromMessage;

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
        return S.of(context).messages_unknown_recipient;
      } else {
        return m.toToDisplay;
      }
    } else {
      if (m.fromToDisplay == "messages_unknown_sender") {
        return S.of(context).messages_unknown_sender;
      } else {
        return m.fromToDisplay;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.message;
    final eventInfoFromMessage = MailUtils.getExtendFromMessageByObjectTypeName(
        ['Object/Aurora\\Modules\\Calendar\\Classes\\Ics'], m);
    final hasUnreadChildren = widget.children
        .where((i) => !i.flagsInJson.contains("\\seen"))
        .isNotEmpty;
    final isUnread = !m.flagsInJson.contains("\\seen");
    final selected = widget.selectionController.isSelected(m.localId);
    final flags = Mail.getFlags(m.flagsInJson);

    final fontWeight =
        flags.contains(MessageFlags.seen) ? FontWeight.w400 : FontWeight.w700;

    Widget _buildThreadCounter(BuildContext context, bool hasUnread) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: hasUnread ? theme.primaryColor : null,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: theme.primaryColor, width: 2.0),
        ),
        child: Text(
          widget.children.length.toString(),
          style:
              TextStyle(color: hasUnread ? Colors.white : theme.primaryColor),
        ),
      );
    }

    Widget dismissibleWrap(Widget child) {
      if (widget.selectionController.enable) {
        return child;
      } else {
        return Dismissible(
          key: Key(m.uid.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              return ConfirmationDialog.show(
                context,
                S.of(context).messages_delete_title,
                S.of(context).messages_delete_desc_with_subject(m.subject),
                S.of(context).btn_delete,
                destructibleAction: true,
              );
            } else if (direction == DismissDirection.startToEnd) {
              await widget.onUnreadMessage(m, isUnread);
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              widget.onDeleteMessage(m);
            }
          },
          background: Container(
            color: theme.primaryColor,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.mail, color: Colors.white, size: 36.0),
                        Text(
                          isUnread
                              ? S.of(context).btn_read
                              : S.of(context).btn_unread,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: theme.errorColor,
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 36.0,
                          ),
                          Text(
                            S.of(context).btn_delete,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          child: child,
        );
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected
            ? theme.brightness == Brightness.light
                ? const Color.fromRGBO(0, 0, 0, 0.05)
                : const Color.fromRGBO(255, 255, 255, 0.05)
            : null,
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onLongPress: changeEnable,
            onTap: widget.selectionController.enable
                ? changeEnable
                : BuildProperty.expandMessageThread &&
                        widget.children.isNotEmpty &&
                        !_showThreads
                    ? _toggleThreads
                    : () => widget.onItemSelected(m),
            child: dismissibleWrap(
              widget.isNote
                  ? ListTile(
                      key: Key(m.uid.toString()),
                      title: Text(
                        m.subject.isNotEmpty
                            ? m.subject
                            : S.of(context).messages_no_subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: fontWeight,
                          fontSize: 16.0,
                          color: theme.textTheme.headline6.color,
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
                              BlocBuilder<SettingsBloc, SettingsState>(
                                builder: (_, state) => Text(
                                  DateFormatting.getShortMessageDate(
                                    timestamp: m.timeStampInUTC,
                                    locale: Localizations.localeOf(context)
                                        .languageCode,
                                    yesterdayWord:
                                        S.of(context).label_message_yesterday,
                                    is24:
                                        (state as SettingsLoaded).is24 ?? true,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: theme.disabledColor.withAlpha(
                                        theme.disabledColor.alpha ~/ 2),
                                  ),
                                ),
                              ),
                              if (widget.selectionController.enable)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Center(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: selected
                                            ? null
                                            : Border.all(
                                                color: theme.primaryColor,
                                                width: 2),
                                        color: selected
                                            ? theme.primaryColor
                                            : null,
                                      ),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : ListTile(
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
                                child: _buildThreadCounter(
                                    context, hasUnreadChildren),
                                onTap: _toggleThreads,
                              ),
                            if (widget.children.isNotEmpty)
                              SizedBox(width: 6.0),
                            Flexible(
                              child: Opacity(
                                opacity: m.subject.isEmpty ? 0.44 : 1.0,
                                child: Text(
                                  m.subject.isNotEmpty
                                      ? m.subject
                                      : S.of(context).messages_no_subject,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: fontWeight,
                                    fontSize: 16.0,
                                    color: theme.textTheme.headline6.color,
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
                              if (m.hasAttachments)
                                if (eventInfoFromMessage != null)
                                  Icon(
                                    Icons.calendar_month,
                                    size: 20,
                                  )
                                else
                                  Icon(Icons.attachment),
                              SizedBox(width: 6.0),
                              BlocBuilder<SettingsBloc, SettingsState>(
                                builder: (_, state) => Text(
                                  DateFormatting.getShortMessageDate(
                                    timestamp: m.timeStampInUTC,
                                    locale: Localizations.localeOf(context)
                                        .languageCode,
                                    yesterdayWord:
                                        S.of(context).label_message_yesterday,
                                    is24:
                                        (state as SettingsLoaded).is24 ?? true,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: theme.disabledColor.withAlpha(
                                        theme.disabledColor.alpha ~/ 2),
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
                              if (widget.selectionController.enable)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Center(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: selected
                                            ? null
                                            : Border.all(
                                                color: theme.primaryColor,
                                                width: 2),
                                        color: selected
                                            ? theme.primaryColor
                                            : null,
                                      ),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child:
                                      BlocBuilder<SettingsBloc, SettingsState>(
                                    builder: (_, state) => Star(
                                      value:
                                          m.flagsInJson.contains("\\flagged"),
                                      enabled: !(state is SettingsLoaded &&
                                          state.connection ==
                                              ConnectivityResult.none),
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
                        MessageItem(
                          widget.isSent,
                          t,
                          [],
                          isNote: widget.isNote,
                          key: Key(t.localId.toString()),
                          selectionController: widget.selectionController,
                          onItemSelected: widget.onItemSelected,
                          onStarMessage: widget.onStarMessage,
                          onDeleteMessage: widget.onDeleteMessage,
                          onUnreadMessage: widget.onUnreadMessage,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 4.0,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              );
            }).toList()
        ],
      ),
    );
  }

  changeEnable() {
    final m = widget.message;
    widget.selectionController.addOrRemove(m.localId, m);
    setState(() {});
  }
}
