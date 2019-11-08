import 'dart:async';
import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_view_app_bar.dart';
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
  PageController _pageCtrl;
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
    if (_setSeenTimer != null) _setSeenTimer.cancel();
  }

  void _startSetSeenTimer(BuildContext context) {
    if (_setSeenTimer != null) {
      _setSeenTimer.cancel();
      _setSeenTimer = null;
    }

    final flagsString = widget.messages[_currentPage].flagsInJson;
    final flags = json.decode(flagsString);
    if (!flags.contains("\\seen")) {
      final uids = [widget.messages[_currentPage].uid];
      _setSeenTimer = new Timer(
        SET_SEEN_DELAY,
        () {
          print("VO: SET_SEEN: ${uids[0]}");
          BlocProvider.of<MailBloc>(context).add(SetSeen(uids));
        },
      );
    }
  }

  void _onAppBarActionSelected(MailViewAppBarAction action) {
    print("VO: _onAppBarActionSelected: $action");
  }

  String _formatTo(Message message) {
    final items =
        Mail.getToForDisplay(message.toInJson, AppStore.authState.userEmail);

    // TODO translate
    if (items.isEmpty) {
      return "No receivers";
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
        child: MailViewAppBar(_onAppBarActionSelected),
      ),
      body: BlocListener(
          bloc: BlocProvider.of<MailBloc>(context),
          listener: (context, state) {
            if (state is DownloadStarted) {
              // TODO translate
              _showSnack("Downloading ${state.fileName}...", context);
            }
            if (state is DownloadFinished) {
              // TODO translate
              if (state.path == null) {
                _showSnack("Download failed", context, isError: true);
              } else {
                _showSnack("File downloaded into: ${state.path}", context);
              }
            }
          },
          child: PageView.builder(
            // TODO VO: temp disabled pageview
            physics: new NeverScrollableScrollPhysics(),
            onPageChanged: (int i) {
              _currentPage = i;
              _startSetSeenTimer(context);
            },
            controller: _pageCtrl,
            itemCount: widget.messages.length,
            itemBuilder: (_, int i) {
              final message = widget.messages[i];
              final attachments = MailAttachment.fromJsonString(
                message.attachmentsInJson,
              );

              return ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Text(
                    // TODO translate
                    message.subject.isNotEmpty ? message.subject : "No subject",
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
                      Text(message.uid.toString()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      // TODO translate
                      Text(
                        _formatTo(message),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      // TODO translate
                      Text(
                        "Show details",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  if (attachments.isNotEmpty) Divider(),
                  ...attachments.map((attachment) {
                    if (attachment.isInline) {
                      return SizedBox();
                    } else {
                      return Attachment(attachment);
                    }
                  }).toList(),
                  Divider(height: 24.0),
                  MessageBody(message, attachments),
                ],
              );
            },
          )),
    );
  }
}
