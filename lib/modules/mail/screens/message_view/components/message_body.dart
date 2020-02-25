import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MessageBody extends StatefulWidget {
  final Message message;
  final String decryptedText;
  final List<MailAttachment> attachments;

  const MessageBody(
    this.message,
    this.attachments,
    this.decryptedText, {
    Key key,
  }) : super(key: key);

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  WebViewController _controller;
  double _webViewHeight = 200.0;

  String _plainData;
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
//      htmlData = '<body style="background-color: ${getWebColor(Theme.of(context).scaffoldBackgroundColor)}; color: ${getWebColor(Theme.of(context).textTheme.body1.color)}">$htmlData</body>';
    } else if (widget.message.plain != null &&
        widget.message.plain.isNotEmpty) {
      plainData = widget.message.plain;
    }

    if (htmlData == null) {
      setState(() => _plainData = plainData);
      return null;
    }
    setState(() => _htmlData = htmlData);
    if (_showImages) {
      htmlData = htmlData.replaceAll(
        "data-x-src=",
        "src=",
      );
    }

//    setState(() => _htmlData = htmlData);
    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    for (final attachment in widget.attachments) {
//      try {
//        final res = await http.get(
//            AuthBloc.currentUser.hostname + attachment.viewUrl,
//            headers: getHeaderWithToken());
//        if (!mounted) break;
//
//        htmlData = htmlData.replaceFirst(
//          "data-x-src-cid=\"${attachment.cid}\"",
//          "src=\"data:image/png;base64, ${base64Encode(res.bodyBytes)}\"",
////          "data:image/png;base64," + base64Encode(res.bodyBytes),
//        );
//        _controller?.loadUrl(_getHtmlUri(htmlData));
//
//        setState(() => _htmlData = htmlData);
//      } catch (err, s) {
//        print("err: ${err}");
//        print("s: ${s}");
//      }

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

  String _getHtmlUri(String html) {
//    final wrappedHtml = MailUtils.wrapInHtml(context, widget.message, html);
//    return Uri.dataFromString(wrappedHtml,
//            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//        .toString();
  return null;
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
              Container(
//          height: _webViewHeight,
                child: _buildMessageBody(),
              ),
              if (_plainData == null)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: AnimatedOpacity(
                      opacity: _pageLoaded && _htmlData != null ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor),
//            child: Container(color: Colors.red),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBody() {
    final plainData = widget.decryptedText ?? _plainData;
    if (_htmlData != null && plainData == null) {
      return WebView(
        key: Key(widget.message.uid.toString()),
        initialUrl: _getHtmlUri(_htmlData),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) => _controller = c,
        navigationDelegate: (NavigationRequest request) {
          if (request.url != _getHtmlUri(_htmlData)) {
            launch(request.url);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onPageFinished: (_) async {
          final height = await _controller
              .evaluateJavascript("document.documentElement.offsetHeight");
          final prevHeight = _webViewHeight;
          final parsedHeight = double.parse(height);
          setState(() {
            if (height != null && prevHeight != parsedHeight) {
              _webViewHeight = parsedHeight > 2000.0 ? 2000.0 : parsedHeight;
            }
          });
          setState(() => _pageLoaded = true);
        },
        gestureRecognizers: Set()
          ..add(Factory(() => HorizontalDragGestureRecognizer())),
      );
    } else if (plainData != null) {
      return SingleChildScrollView(child: Text(plainData));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
