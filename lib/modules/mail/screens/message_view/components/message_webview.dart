import 'dart:async';
import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'attachments_dialog.dart';

class MessageWebViewActions {
  static const SHOW_ATTACHMENTS = "SHOW_ATTACHMENTS";
  static const SHOW_INFO = "SHOW_INFO";
}

class MessageWebView extends StatefulWidget {
  final Message message;
  final List<MailAttachment> attachments;

  const MessageWebView(this.message, this.attachments, {Key key})
      : super(key: key);

  @override
  _MessageWebViewState createState() => _MessageWebViewState();
}

class _MessageWebViewState extends State<MessageWebView> {
  WebViewController _controller;
  String _htmlData;
  bool _pageLoaded = false;
  bool _showImages = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showImages = !widget.message.hasExternals || widget.message.safety;
    _getHtmlWithImages();
  }

  void _getHtmlWithImages() async {
    String htmlData;
    String plainData;
    if (widget.message.html != null && widget.message.html.isNotEmpty) {
      htmlData = widget.message.html;
    } else if (widget.message.plain != null) {
      plainData = widget.message.plain;
    }

    if (htmlData == null) {
      setState(() => _htmlData = plainData ?? "");
      return null;
    }
    setState(() => _htmlData = htmlData);
    if (_showImages) {
      htmlData = htmlData.replaceAll(
        "data-x-src=",
        "src=",
      );
    }

    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    for (final attachment in widget.attachments) {
      htmlData = htmlData.replaceFirst(
        "data-x-src-cid=\"${attachment.cid}\"",
        "src=\"${user.hostname}${attachment.viewUrl.replaceFirst("mail-attachment/", "mail-attachments-cookieless/")}&AuthToken=${user.token}\"",
      );
    }

    if (_htmlData != null) {
      _controller?.loadUrl(_getHtmlUri(htmlData));
    }
    setState(() => _htmlData = htmlData);
  }

  String _formatTo(Message message) {
    final items = Mail.getToForDisplay(context, message.toInJson,
        BlocProvider.of<AuthBloc>(context).currentAccount.email);

    if (items.isEmpty) {
      return i18n(context, "messages_no_receivers");
    } else {
      return items.join(", ");
    }
  }

  String _getHtmlUri(String html) {
    final state = BlocProvider.of<SettingsBloc>(context).state;

    final date = DateFormatting.getDetailedMessageDate(
      timestamp: widget.message.timeStampInUTC,
      locale: Localizations.localeOf(context).languageCode,
      yesterdayWord: i18n(context, "formatting_yesterday"),
      is24: (state as SettingsLoaded).is24 ?? true,
    );

    final wrappedHtml = MailUtils.wrapInHtml(
      context,
      message: widget.message,
      to: _formatTo(widget.message),
      date: date,
      body: html,
      showAttachmentsBtn: widget.attachments.where((a) => !a.isInline).isNotEmpty,
    );
    return Uri.dataFromString(wrappedHtml,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  FutureOr<NavigationDecision> _onWebViewNavigateRequest(NavigationRequest request) async {
    if (request.url.endsWith(MessageWebViewActions.SHOW_INFO)) {
      // TODO: implement showing message info
      return NavigationDecision.prevent;
    } else if (request.url.endsWith(MessageWebViewActions.SHOW_ATTACHMENTS)) {
      final messageViewBloc = BlocProvider.of<MessageViewBloc>(context);
      AttachmentsDialog.show(context, widget.attachments, messageViewBloc);
      return NavigationDecision.prevent;
    } else if (request.url != _getHtmlUri(_htmlData)) {
      launch(request.url);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!_showImages)
          FlatButton.icon(
            icon: Icon(Icons.image),
            label: Text(i18n(context, "messages_show_images")),
            onPressed: () {
              setState(() => _showImages = true);
              _getHtmlWithImages();
            },
          ),
        Flexible(
          child: Stack(
            children: [
              WebView(
                key: Key(widget.message.uid.toString()),
                initialUrl: _getHtmlUri(_htmlData),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController c) => _controller = c,
                navigationDelegate: _onWebViewNavigateRequest,
                onPageFinished: (_) async => setState(() => _pageLoaded = true),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedOpacity(
                    opacity: _pageLoaded && _htmlData != null ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 100),
                    child: Container(color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
