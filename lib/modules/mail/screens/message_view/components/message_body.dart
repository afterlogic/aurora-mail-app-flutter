import 'dart:convert';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MessageBody extends StatefulWidget {
  final Message message;
  final List<MailAttachment> attachments;

  const MessageBody(this.message, this.attachments, {Key key})
      : super(key: key);

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  WebViewController _controller;
  double _webViewHeight = 200.0;

  String _plainData;
  String _htmlData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

    for (final attachment in widget.attachments) {
      try {
        final res = await http.get(
            AuthBloc.currentUser.hostname + attachment.viewUrl,
            headers: getHeaderWithToken());

        htmlData = htmlData.replaceFirst(
          "cid:${attachment.cid}",
          "data:image/png;base64," + base64Encode(res.bodyBytes),
        );
      } catch (err, s) {
        print("VO: err: ${err}");
        print("VO: s: ${s}");
      }
    }

    setState(() => _htmlData = htmlData);
  }

  String getWebColor(Color colorObj) {
    final base = colorObj.toString();
    final color = base.substring(base.length - 7, base.length - 1);
    final opacity = base.substring(base.length - 9, base.length - 7);
    return "#$color$opacity";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _htmlData == null ? null : _webViewHeight,
        child: _buildMessageBody());
  }

  Widget _buildMessageBody() {
    if (_htmlData != null) {
      return WebView(
        key: Key(widget.message.uid.toString()),
        initialUrl: Uri.dataFromString(_htmlData,
                mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
            .toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) => _controller = c,
        navigationDelegate: (NavigationRequest request) {
          launch(request.url);
          return NavigationDecision.prevent;
        },
        onPageFinished: (_) async {
          final height = await _controller
              .evaluateJavascript("document.documentElement.offsetHeight");
          final prevHeight = _webViewHeight;
          final parsedHeight = double.parse(height);
          setState(() {
//            print("VO: parsedHeight: ${parsedHeight}");
            if (height != null && prevHeight != parsedHeight) {
              _webViewHeight = parsedHeight > 1500.0 ? 1500.0 : parsedHeight;
            }
          });
        },
        gestureRecognizers: Set()
          ..add(Factory(() => HorizontalDragGestureRecognizer())),
      );
    } else if (_plainData != null) {
      return Text(_plainData);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
