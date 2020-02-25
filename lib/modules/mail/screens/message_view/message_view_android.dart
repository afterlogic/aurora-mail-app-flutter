import 'dart:async';
import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/mail_bottom_bar.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_view_app_bar.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/dialog/request_password_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_webview.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_worker/crypto_worker.dart';
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

class _MessageViewAndroidState extends State<MessageViewAndroid>
    with TickerProviderStateMixin {
  MessageViewBloc _messageViewBloc;
  String decryptedText;
  TabController _tabCtrl;
  int _currentPage;

  Timer _setSeenTimer;

  @override
  void initState() {
    super.initState();
    _tabCtrl = new TabController(length: 2, vsync: this);
    _currentPage = widget.initialPage ?? 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    _messageViewBloc = MessageViewBloc(
      user: authBloc.currentUser,
      account: BlocProvider.of<AuthBloc>(context).currentAccount,
    );
    _messageViewBloc.add(CheckEncrypt(widget.messages[_currentPage].plain));
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
    final flags = json.decode(flagsString) as List;
    if (!flags.contains("\\seen")) {
      _setSeenTimer = new Timer(
        SET_SEEN_DELAY,
        () => BlocProvider.of<MailBloc>(context)
            .add(SetSeen([widget.messages[_currentPage]], true)),
      );
    }
  }

  void _onAppBarActionSelected(MailViewAppBarAction action) {
    // ignore: close_sinks
    final mailBloc = BlocProvider.of<MailBloc>(context);
    final contactsBloc = BlocProvider.of<ContactsBloc>(context);
    final msg = widget.messages[_currentPage];
    switch (action) {
      case MailViewAppBarAction.reply:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: Reply(msg),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.replyToAll:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: ReplyToAll(msg),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.forward:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: Forward(msg),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.toSpam:
        return null;
      case MailViewAppBarAction.delete:
        return _deleteMessage();
    }
  }

  _decrypt(EncryptType type) async {
    String pass;
    final message = widget.messages[_currentPage];
    if (type == EncryptType.Encrypt) {
      final result = await showDialog(
          context: context, builder: (_) => RequestPasswordDialog());
      if (result is RequestPasswordDialogResult) {
        pass = result.pass;
      } else {
        return;
      }
    }

    _messageViewBloc.add(DecryptBody(
      type,
      pass,
      jsonDecode(message.fromInJson)["@Collection"][0]["Email"].toString(),
      message.plainRaw,
    ));
  }

  void _deleteMessage() async {
    final message = widget.messages[_currentPage];
    final delete = await ConfirmationDialog.show(
      context,
      i18n(context, "messages_delete_title"),
      i18n(context, "messages_delete_desc"),
      i18n(context, "btn_delete"),
      destructibleAction: true,
    );
    if (delete == true) {
      BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(
        uids: [message.uid],
        folderRawName: message.folder,
      ));
      Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
    }
  }

//  String _formatTo(Message message) {
//    final items = Mail.getToForDisplay(
//        context, message.toInJson, BlocProvider.of<AuthBloc>(context).currentAccount.email);
//
//    if (items.isEmpty) {
//      return i18n(context, "messages_no_receivers");
//    } else {
//      return items.join(" | ");
//    }
//  }

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
    final showTabs = attachments.where((a) => !a.isInline).isNotEmpty;

    return BlocProvider<MessageViewBloc>.value(
      value: _messageViewBloc,
      child: Scaffold(
        appBar: MailViewAppBar(_onAppBarActionSelected),
        body: BlocListener(
          bloc: _messageViewBloc,
          listener: (context, state) {
            if (state is DecryptComplete) {
              decryptedText = state.text;
              setState(() {});

              _showSnack(
                  i18n(
                    context,
                    state.verified
                        ? "decrypted_and_verified"
                        : "decrypted_but_not_verified",
                  ),
                  context);
            }
            if (state is DownloadStarted) {
              _showSnack(
                  i18n(context, "messages_attachment_downloading",
                      {"fileName": state.fileName}),
                  context);
            }
            if (state is MessagesViewError) {
              _showSnack(state.errorMsg, context, isError: true);
            }
            if (state is DownloadFinished) {
              if (state.path == null) {
                _showSnack(i18n(context, "messages_attachment_download_failed"),
                    context,
                    isError: true);
              } else {
                _showSnack(
                    i18n(context, "messages_attachment_download_success",
                        {"path": state.path}),
                    context);
              }
            }
          },
          child: MessageWebView(message, attachments,decryptedText),
//          child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                ConstrainedBox(
//                  constraints: BoxConstraints(maxHeight: 107.0),
//                  child: SingleChildScrollView(
//                    child: Text(
//                      message.subject.isNotEmpty
//                          ? message.subject
//                          : i18n(context, "messages_no_subject"),
//                      style: Theme.of(context).textTheme.display1.copyWith(
//                            fontSize: 26.0,
//                          ),
//                    ),
//                  ),
//                ),
//                SizedBox(height: 12.0),
//                Divider(height: 20.0),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.baseline,
//                  textBaseline: TextBaseline.alphabetic,
//                  children: <Widget>[
//                    Text(
//                      message.fromToDisplay,
//                      style: Theme.of(context).textTheme.subhead,
//                    ),
//                    BlocBuilder<SettingsBloc, SettingsState>(
//                      builder: (_, state) => Text(DateFormatting.getDetailedMessageDate(
//                        timestamp: message.timeStampInUTC,
//                        locale: Localizations.localeOf(context).languageCode,
//                        yesterdayWord: i18n(context, "formatting_yesterday"),
//                        is24: (state as SettingsLoaded).is24 ?? true,
//                      )),
//                    ),
//                  ],
//                ),
//                SizedBox(height: 10.0),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.baseline,
//                  textBaseline: TextBaseline.alphabetic,
//                  children: <Widget>[
//                    Text(
//                      _formatTo(message),
//                      style: Theme.of(context).textTheme.caption,
//                    ),
//                  ],
//                ),
//                Divider(),
//                ...showTabs
//                    ? _buildWithTabs(message, attachments)
//                    : _buildWithoutTabs(message, attachments),
//              ],
//            ),
//          ),
        ),
        bottomNavigationBar: MailBottomBar(
          onDecrypt: _decrypt,
        ),
      ),
    );
  }

  List<Widget> _buildWithTabs(
      Message message, List<MailAttachment> attachments) {
    return [
      SizedBox(
        height: 35.0,
        child: TabBar(
          controller: _tabCtrl,
          labelColor: Theme.of(context).textTheme.body2.color,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            Tab(text: i18n(context, "messages_view_tab_message_body")),
            Tab(text: i18n(context, "messages_view_tab_attachments")),
          ],
        ),
      ),
      Flexible(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabCtrl,
          children: <Widget>[
            MessageBody(message, attachments, decryptedText),
            Center(
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
          ],
        ),
      )
    ];
  }

  List<Widget> _buildWithoutTabs(
      Message message, List<MailAttachment> attachments) {
    return [Flexible(child: MessageBody(message, attachments, decryptedText))];
  }
}
