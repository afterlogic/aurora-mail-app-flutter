//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComposeWebViewController {
  WebViewController _webViewController;
  String _text = "";
  bool _isHtml = true;
  bool showImage = false;

  Future setMessage(String text, Message message, User user) async {
    if (showImage) {
      text = text
          .replaceAll("data-x-src=", "src=")
          .replaceAll("src=\"http:", "src=\"https:");

      final document = html.parse(text);

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
      text = document.outerHtml;
    }
    ;
    final attachments = MailAttachment.fromJsonString(
      message.attachmentsInJson,
    );
    for (final attachment in attachments) {
      text = text.replaceFirst(
        "data-x-src-cid=\"${attachment.cid}\"",
        "src=\"${user.hostname}${attachment.viewUrl.replaceFirst("mail-attachment/", "mail-attachments-cookieless/")}&AuthToken=${user.token}\"",
      );
    }

    setText(text);
  }

  Future setText(String text) async {
    _text = text;
    if (_webViewController != null) {
      await _webViewController
          .runJavaScript("setBodyContent(${json.encode(_text)})");
    }
  }

  Future<String> getText() async {
    if (_webViewController == null) {
      return _text;
    } else {
      final text = await _webViewController
          .runJavaScriptReturningResult("getBodyContent()");
      try {
        final decoded = json.decode(text.toString()) as String;
        return decoded;
      } catch (e) {
        return text.toString();
      }
    }
  }

  setIsHtml(bool html) async {
    _isHtml = html;
    if (_webViewController != null) {
      if (html) {
        await _webViewController.runJavaScript("setHtml()");
      } else {
        await _webViewController.runJavaScript("setPlain()");
      }
    }
  }

  init(WebViewController webViewController) {
    _webViewController = webViewController;
    setText(_text);
    setIsHtml(_isHtml);
  }

  void dispose() {
    _webViewController = null;
  }
}

class ComposeWebView extends StatefulWidget {
  final ComposeWebViewController textCtrl;
  final bool enable;
  final bool removeForcedHeight;
  final Function init;

  const ComposeWebView(
      {Key key,
      this.textCtrl,
      this.enable,
      this.init,
      this.removeForcedHeight = false})
      : super(key: key);

  @override
  _ComposeWebViewState createState() => _ComposeWebViewState();
}

class _ComposeWebViewState extends State<ComposeWebView> {
  WebViewController _ctrl;
  String initUrl;

  @override
  initState() {
    super.initState();
    // On Android, hybrid composition (SurfaceAndroidWebView) is now the default (webview_flutter 3.0.0)
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) => {init()},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: navigationDelegate),
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initHtml();
  }

  initHtml() {
    var htmlData = MailUtils.wrapInHtmlEditor(
      context,
      "",
      true,
      widget.removeForcedHeight
    );

    if (true) {
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
    initUrl = Uri.dataFromString(
      htmlData,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    _ctrl.loadRequest(Uri.parse(initUrl));
  }

  dispose() {
    super.dispose();
    widget.textCtrl.dispose();
  }

  Future<NavigationDecision> navigationDelegate(
      NavigationRequest navigation) async {
    if (initUrl == navigation.url) {
      return NavigationDecision.navigate;
    }
    launch(navigation.url);
    return NavigationDecision.prevent;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _ctrl,
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
    );
  }

  init() async {
    widget.textCtrl.init(_ctrl);
  }
}
