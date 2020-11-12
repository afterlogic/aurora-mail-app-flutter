import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:webview_flutter/webview_flutter.dart';

class ComposeWebViewController {
  String _text = "";
  WebViewController _webViewController;
  BuildContext _context;

  void setText(String text) {
    _text = text;

    if (_webViewController != null) {
      final html = _formatToWebView(text);
      _webViewController.loadUrl(html);
    }
  }

  Future<String> getText() async {
    if (_webViewController == null) {
      return _text;
    } else {
      final text =
          await _webViewController.evaluateJavascript("getBodyContent()");
      final decoded = json.decode(text) as String;
      return decoded;
    }
  }

  String _formatToWebView(String text) {
    var htmlData = MailUtils.wrapInHtmlEditor(
      _context,
      text ?? "",
    );
    return Uri.dataFromString(
      htmlData,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
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
    return Uri.dataFromString(
      htmlData,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
  }
}

class ComposeWebView extends StatefulWidget {
  final ComposeWebViewController textCtrl;
  final bool enable;

  const ComposeWebView({Key key, this.textCtrl, this.enable}) : super(key: key);

  @override
  _ComposeWebViewState createState() => _ComposeWebViewState();
}

class _ComposeWebViewState extends State<ComposeWebView> {
  WebViewController _ctrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      gestureRecognizers: {
        Factory<VerticalDragGestureRecognizer>(() {
          return VerticalDragGestureRecognizer();
        }),
        Factory<LongPressGestureRecognizer>(() {
          return LongPressGestureRecognizer();
        }),
        Factory<TapGestureRecognizer>(() {
          return TapGestureRecognizer();
        }),
      },
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (c) {
        _ctrl = c;
        init();
      },
    );
  }

  init() {
    widget.textCtrl._context = context;
    widget.textCtrl._webViewController = _ctrl;
    widget.textCtrl.setText(widget.textCtrl._text);
  }
}
