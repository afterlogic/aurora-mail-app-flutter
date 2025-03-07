//@dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/folder.dart';
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
import 'package:aurora_mail/modules/mail/screens/message_view/components/message_webview.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/components/route_with_finish_callback.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/dialog/request_password_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/dialog/move_message.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_headers.dart';

class MessageViewAndroid extends StatefulWidget {
  final Message message;
  final RouteAnimationListener routeAnimationListener;

  const MessageViewAndroid(this.message, this.routeAnimationListener);

  @override
  _MessageViewAndroidState createState() => _MessageViewAndroidState();
}

class _MessageViewAndroidState extends BState<MessageViewAndroid>
    with TickerProviderStateMixin {
  final webViewKey = GlobalKey<MessageWebViewState>();
  PgpSettingsBloc pgpBloc;
  ContactsBloc contactsBloc;
  MessageViewBloc _messageViewBloc;
  String decryptedText;
  bool animationFinished = false;
  Timer _setSeenTimer;

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    contactsBloc = BlocProvider.of<ContactsBloc>(context);

    pgpBloc = AppInjector.instance.pgpSettingsBloc(authBloc);
    if (widget.routeAnimationListener.isCompleted == true) {
      animationFinished = true;
    } else {
      widget.routeAnimationListener.onComplete = () {
        animationFinished = true;
        setState(() {});
      };
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    _messageViewBloc = MessageViewBloc(
      user: authBloc.currentUser,
      account: BlocProvider.of<AuthBloc>(context).currentAccount,
    );
    if (BuildProperty.cryptoEnable) {
      _messageViewBloc.add(CheckEncrypt(widget.message.rawBody));
    }
    _startSetSeenTimer(context);
    _messageViewBloc.add(GetFolderType(widget.message.folder));
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

    final flagsString = widget.message.flagsInJson;
    final flags = json.decode(flagsString) as List;
    if (!flags.contains("\\seen")) {
      _setSeenTimer = new Timer(
        SET_SEEN_DELAY,
        () => BlocProvider.of<MailBloc>(context)
            .add(SetSeen([widget.message], true)),
      );
    }
  }

  void _onAppBarActionSelected(MailViewAppBarAction action) async {
    // ignore: close_sinks
    final showImage = webViewKey.currentState.showImages;
    final mailBloc = BlocProvider.of<MailBloc>(context);
    final contactsBloc = BlocProvider.of<ContactsBloc>(context);
    final msg = widget.message;
    switch (action) {
      case MailViewAppBarAction.reply:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: Reply(msg, showImage),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.replyToAll:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: ReplyToAll(msg, showImage),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.forward:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: Forward(msg, showImage),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.resend:
        Navigator.pop(context);
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: Resend(msg, showImage),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
      case MailViewAppBarAction.toSpam:
        Navigator.pop(context);
        return _spam(true);
      case MailViewAppBarAction.notSpam:
        Navigator.pop(context);
        return _spam(false);
      case MailViewAppBarAction.showLightEmail:
        return null;
      case MailViewAppBarAction.delete:
        return _deleteMessage();
      case MailViewAppBarAction.move:
        final result = await AMDialog.show(
          context: context,
          builder: (_) => MoveMessageDialog(
            [widget.message],
            BlocProvider.of<MessagesListBloc>(context),
            BlocProvider.of<MailBloc>(context),
          ),
        );
        if (result == true) {
          Navigator.popUntil(
              context, ModalRoute.withName(MessagesListRoute.name));
        }
        break;
      case MailViewAppBarAction.showHeaders:
        Navigator.pushNamed(
          context,
          MessageHeadersRoute.name,
          arguments: MessageHeadersRouteArg(
            widget.message.headers,
          ),
        );
        break;
      case MailViewAppBarAction.forwardAsAttachment:
        final args = new ComposeScreenArgs(
          mailBloc: mailBloc,
          contactsBloc: contactsBloc,
          composeAction: ForwardAsAttachment(msg),
        );
        Navigator.pushNamed(context, ComposeRoute.name, arguments: args);
        break;
    }
  }

  _decrypt(EncryptType type) async {
    String pass;
    final message = widget.message;
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
      message.rawBody,
    ));
  }

  void _deleteMessage() async {
    final message = widget.message;
    final delete = await ConfirmationDialog.show(
      context,
      S.of(context).messages_delete_title,
      S.of(context).messages_delete_desc,
      S.of(context).btn_delete,
      destructibleAction: true,
    );
    if (delete == true) {
      BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(
        messages: [message],
      ));
      Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
    }
  }

//  String _formatTo(Message message) {
//    final items = Mail.getToForDisplay(
//        context, message.toInJson, BlocProvider.of<AuthBloc>(context).currentAccount.email);
//
//    if (items.isEmpty) {
//      return S.of(context).messages_no_receivers);
//    } else {
//      return items.join(" | ");
//    }
//  }
  void _showError(ErrorToShow error, BuildContext context,
      {bool isError = false, Map<String, String> arg}) {
    showErrorSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      msg: error,
      arg: arg,
      isError: isError,
    );
  }

  void _showSnack(String msg, BuildContext context,
      {bool isError = false}) {
    showSnack(
      context: context,
      scaffoldState: Scaffold.of(context),
      message: msg,
      isError: isError,
    );
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    final attachments = MailAttachment.fromJsonString(
      message.attachmentsInJson,
    );

    return BlocProvider<MessageViewBloc>.value(
      value: _messageViewBloc,
      child: Scaffold(
        appBar: MailViewAppBar(
          _onAppBarActionSelected,
          _messageViewBloc,
        ),
        body: !animationFinished
            ? SizedBox.shrink()
            : BlocListener(
                bloc: _messageViewBloc,
                listener: (context, state) {
                  if (state is DecryptComplete) {
                    decryptedText = MailUtils.plainToHtml(state.text);
                    setState(() {});

                    _showSnack(
                        state.type == EncryptType.Sign
                            ? (state.verified
                                ? S.of(context).label_pgp_verified
                                : S.of(context).label_pgp_not_verified)
                            : (state.verified
                                ? S.of(context).label_pgp_decrypted_and_verified
                                : S.of(context).label_pgp_decrypted_but_not_verified),
                        context);
                  }
                  if (state is DownloadStarted) {
                    _showSnack(
                      S.of(context).messages_attachment_downloading(state.fileName),
                      context,
                    );
                  }
                  if(state is SuccessChangedInviteStatus) {
                    _showSnack(
                     'Invitation status was updated successfully',
                      context,
                    );
                  }
                  if (state is MessagesViewError) {
                    _showError(
                      state.errorMsg,
                      context,
                      isError: true,
                      arg: state.arg,
                    );
                  }
                  if (state is DownloadFinished) {
                    if (state.path == null) {
                      _showSnack(
                        S.of(context).messages_attachment_download_failed,
                        context,
                        isError: true,
                      );
                    } else {
                      _showSnack(
                        S.of(context).messages_attachment_download_success(state.path),
                        context,
                      );
                    }
                  }
                },
                child: MessageWebView(
                  message,
                  attachments,
                  decryptedText,
                  pgpBloc,
                  contactsBloc,
                  _messageViewBloc,
                  key: webViewKey,
                ),
              ),
        bottomNavigationBar: BuildProperty.cryptoEnable
            ? MailBottomBar(
                onDecrypt: _decrypt,
              )
            : null,
      ),
    );
  }

  void _spam(bool into) {
    final message = widget.message;
    BlocProvider.of<MessagesListBloc>(context).add(MoveMessages(
      [message],
      into ? FolderType.spam : FolderType.inbox,
    ));
    Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
  }
}
