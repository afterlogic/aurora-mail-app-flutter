import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import 'attachments_dialog.dart';

class MessageWebViewActions {
  static const SHOW_ATTACHMENTS = "MessageWebViewActions.SHOW_ATTACHMENTS";
  static const SHOW_INFO = "MessageWebViewActions.SHOW_INFO";
  static const DOWNLOAD_ATTACHMENT =
      "MessageWebViewActions.DOWNLOAD_ATTACHMENT";
}

class MessageWebView extends StatefulWidget {
  final Message message;
  final List<MailAttachment> attachments;
  final String decrypted;

  const MessageWebView(this.message, this.attachments, this.decrypted,
      {Key key})
      : super(key: key);

  @override
  _MessageWebViewState createState() => _MessageWebViewState();
}

class _MessageWebViewState extends BState<MessageWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String _htmlData;
  bool _pageLoaded = true;
  bool _showImages = false;
  ThemeData theme;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = flutterWebviewPlugin.onStateChanged
        .listen((state) => _onWebViewNavigateRequest(state));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showImages = !widget.message.hasExternals || widget.message.safety;
    theme = Theme.of(context);
    _getHtmlWithImages();
  }

  @override
  void didUpdateWidget(MessageWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.decrypted != widget.decrypted) {
      _getHtmlWithImages();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
    flutterWebviewPlugin.close();
  }

  void _getHtmlWithImages() async {
    String htmlData;
    if (widget.decrypted != null) {
      htmlData = widget.decrypted;
    } else {
      htmlData = widget.message.htmlBody;
    }
    setState(() => _htmlData = htmlData);
    if (_showImages) {
      htmlData = htmlData
          .replaceAll("data-x-src=", "src=")
          .replaceAll("src=\"http:", "src=\"https:");

      final document = html.parse(htmlData);

      void getAllChildren(nodes) {
        nodes.forEach((c) {
          c.nodes.forEach((node) {
            if (node.attributes.containsKey("data-x-style-url") as bool) {
              var backgroundImageUrl =
                  node.attributes["data-x-style-url"] as String;
              backgroundImageUrl =
                  backgroundImageUrl.replaceAll("http://", "https://");
              node.attributes.remove("data-x-style-url");

              String style = node.attributes["style"] as String;
              style = style.endsWith(";") ? style : style + "; ";
              style += backgroundImageUrl;
              node.attributes["style"] = style;
            }
          });

          getAllChildren(c.nodes);
        });
      }

      getAllChildren(document.nodes.toList());
      htmlData = document.outerHtml;
    }

    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    for (final attachment in widget.attachments) {
      htmlData = htmlData.replaceFirst(
        "data-x-src-cid=\"${attachment.cid}\"",
        "src=\"${user.hostname}${attachment.viewUrl.replaceFirst("mail-attachment/", "mail-attachments-cookieless/")}&AuthToken=${user.token}\"",
      );
    }

    if (_htmlData != null) {
      flutterWebviewPlugin.reloadUrl(_getHtmlUri(htmlData));
    }
    setState(() => _htmlData = htmlData);
  }

  String _formatTo(Message message) {
    final items = Mail.getToForDisplay(
      context,
      message.toInJson,
      BlocProvider.of<AuthBloc>(context).currentAccount.email,
    );

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
      attachments: widget.attachments.where((a) => !a.isInline).toList(),
      showLightEmail: false,
    );
    return Uri.dataFromString(wrappedHtml,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  void _startDownload(String downloadUrl) {
    final attachment = widget.attachments
        .firstWhere((a) => !a.isInline && a.downloadUrl == downloadUrl);
    BlocProvider.of<MessageViewBloc>(context)
        .add(DownloadAttachment(attachment));
    final msg = i18n(context, "messages_attachment_downloading",
        {"fileName": attachment.fileName});
    Fluttertoast.showToast(
      msg: msg,
      timeInSecForIos: 2,
      backgroundColor:
          Platform.isIOS ? theme.disabledColor.withOpacity(0.5) : null,
    );
  }

  _onWebViewNavigateRequest(WebViewStateChanged state) async {
    if (state.type == WebViewState.startLoad) {
      if (state.url.endsWith(MessageWebViewActions.SHOW_INFO)) {
        flutterWebviewPlugin.goBack();
      } else if (state.url.endsWith(MessageWebViewActions.SHOW_ATTACHMENTS)) {
        final messageViewBloc = BlocProvider.of<MessageViewBloc>(context);
        AttachmentsDialog.show(context, widget.attachments, messageViewBloc);
        flutterWebviewPlugin.stopLoading();
      } else if (state.url
          .endsWith(MessageWebViewActions.DOWNLOAD_ATTACHMENT)) {
        final parts =
            state.url.split(MessageWebViewActions.DOWNLOAD_ATTACHMENT);
        final downloadUrl = parts[parts.length - 2];
        _startDownload(downloadUrl);
        flutterWebviewPlugin.goBack();
      } else if (state.url != _getHtmlUri(_htmlData)) {
        launch(state.url);
        flutterWebviewPlugin.goBack();
      } else {
//      return NavigationDecision.navigate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!_showImages)
          Container(
            padding: const EdgeInsets.all(6.0),
            color: Color(0xFFffffc5),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: i18n(context, "messages_images_security_alert") + " ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: i18n(context, "messages_show_images"),
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() => _showImages = true);
                        _getHtmlWithImages();
                      },
                  ),
                ],
              ),
            ),
          ),
        Flexible(
          child: Stack(
            children: [
              WebviewScaffold(
                key: Key(widget.message.uid.toString()),
                url: _getHtmlUri(_htmlData),
                withJavascript: true,
//                onPageFinished: (_) async => setState(() => _pageLoaded = true),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedOpacity(
                    opacity: _pageLoaded && _htmlData != null ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 100),
                    child: Container(color: theme.scaffoldBackgroundColor),
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
