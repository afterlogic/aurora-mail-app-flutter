import 'dart:async';
import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_types.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_view_app_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/attachment.dart';
import 'components/message_body.dart';

class MessageViewAndroid extends StatefulWidget {
  final List<Message> messages;
  final int initialPage;

  const MessageViewAndroid(this.messages, this.initialPage);

  @override
  _MessageViewAndroidState createState() => _MessageViewAndroidState();
}

class _MessageViewAndroidState extends State<MessageViewAndroid> {
  final _messageViewBloc = new MessageViewBloc();

  PageController _pageCtrl;
  bool _showAttachments = false;
  int _currentPage;

  Timer _setSeenTimer;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? 0;
    _pageCtrl = new PageController(initialPage: _currentPage, keepPage: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startSetSeenTimer(context);
  }

  @override
  void dispose() {
    super.dispose();
    _messageViewBloc.close();
    _setSeenTimer?.cancel();
  }

  void _startSetSeenTimer(BuildContext context) {
    _setSeenTimer?.cancel();
    _setSeenTimer = null;

    final flagsString = widget.messages[_currentPage].flagsInJson;
    final flags = json.decode(flagsString);
    if (!flags.contains("\\seen")) {
      final uids = [widget.messages[_currentPage].uid];
      _setSeenTimer = new Timer(
        SET_SEEN_DELAY,
        () => BlocProvider.of<MailBloc>(context).add(SetSeen(uids)),
      );
    }
  }

  void _onAppBarActionSelected(MailViewAppBarAction action) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<MailBloc>(context);
    final msg = widget.messages[_currentPage];
    switch (action) {
      case MailViewAppBarAction.reply:
        final args = new ComposeScreenArgs(
            bloc: bloc, message: msg, composeType: ComposeType.reply);
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.replyToAll:
        final args = new ComposeScreenArgs(
            bloc: bloc, message: msg, composeType: ComposeType.replyAll);
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.forward:
        final args = new ComposeScreenArgs(
            bloc: bloc, message: msg, composeType: ComposeType.forward);
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.toSpam:
        return null;
      case MailViewAppBarAction.delete:
        return _deleteMessage();
    }
  }

  void _deleteMessage() async {
    final message = widget.messages[_currentPage];
    final delete = await ConfirmationDialog.show(
        context,
        S.of(context).messages_delete_title,
        S.of(context).messages_delete_desc,
        S.of(context).btn_delete);
    if (delete == true) {
      BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages([message]));
      Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
    }
  }

  String _formatTo(Message message) {
    final items = Mail.getToForDisplay(
        context, message.toInJson, AuthBloc.currentAccount.email);

    if (items.isEmpty) {
      return S.of(context).messages_no_receivers;
    } else {
      return items.join(" | ");
    }
  }

  void _showSnack(String msg, BuildContext context, {bool isError = false}) {
    showSnack(
        context: context,
        scaffoldState: Scaffold.of(context),
        msg: msg,
        isError: isError);
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.messages[_currentPage];
    final attachments = MailAttachment.fromJsonString(
      message.attachmentsInJson,
    );
    return BlocProvider<MessageViewBloc>.value(
      value: _messageViewBloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
          child: MailViewAppBar(_onAppBarActionSelected),
        ),
        body: BlocListener(
          bloc: _messageViewBloc,
          listener: (context, state) {
            if (state is DownloadStarted) {
              _showSnack(
                  S.of(context).messages_attachment_downloading(state.fileName),
                  context);
            }
            if (state is DownloadFinished) {
              if (state.path == null) {
                _showSnack(
                    S.of(context).messages_attachment_download_failed, context,
                    isError: true);
              } else {
                _showSnack(
                    S
                        .of(context)
                        .messages_attachment_download_success(state.path),
                    context);
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.subject.isNotEmpty
                      ? message.subject
                      : S.of(context).messages_no_subject,
                  style: Theme.of(context).textTheme.display1.copyWith(
                        fontSize: 26.0,
                      ),
                ),
                SizedBox(height: 12.0),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      message.fromToDisplay,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Text(DateFormatting.formatDateFromSeconds(
                      message.timeStampInUTC,
                      Localizations.localeOf(context).languageCode,
                    )),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                      _formatTo(message),
                      style: Theme.of(context).textTheme.caption,
                    ),

//                      Text(
//                        S.of(context).messages_show_details,
//                        style: TextStyle(decoration: TextDecoration.underline),
//                      ),
                  ],
                ),
                if (attachments.isNotEmpty) Divider(),
                GestureDetector(
                  onTap: () =>
                      setState(() => _showAttachments = !_showAttachments),
                  child: Text(
                    _showAttachments
                        ? S.of(context).messages_show_message_body
                        : S.of(context).messages_show_attachments,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                if (attachments.isNotEmpty)
                  Flexible(
                    flex: _showAttachments ? 1 : 0,
                    child: Container(
                      height: _showAttachments ? null : 0,
                      child: ListView(
                        children: attachments.map((attachment) {
                          if (attachment.isInline) {
                            return SizedBox();
                          } else {
                            return Attachment(attachment);
                          }
                        }).toList(),
                      ),
                    ),
                  ),
                Divider(height: 24.0),
                Flexible(
                    flex: _showAttachments ? 0 : 1,
                    child: Container(
                        height: _showAttachments ? 0 : null,
                        child: MessageBody(message, attachments))),
              ],
            ),
          ),
//            PageView.builder(
//              onPageChanged: (int i) {
//                _currentPage = i;
//                _startSetSeenTimer(context);
//              },
//              controller: _pageCtrl,
//              itemCount: widget.messages.length,
//              itemBuilder: (_, int i) {
//                final message = widget.messages[i];
//                final attachments = MailAttachment.fromJsonString(
//                  message.attachmentsInJson,
//                );
//
//                return
//              },
//            )),
        ),
      ),
    );
  }
}
