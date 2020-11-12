import 'dart:convert';

import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComposeWebViewController {
  String _text = "";
  WebViewController _webViewController;
  bool _isHtml = true;

  Future setText(String text) async {
    _text = text;
    if (_webViewController != null) {
      await _webViewController.evaluateJavascript("setBodyContent(${json.encode(text)})");
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

  setIsHtml(bool html) async {
    _isHtml = html;
    if (_webViewController != null) {
      if (html) {
        await _webViewController.evaluateJavascript("setHtml()");
      } else {
        await _webViewController.evaluateJavascript("setPlain()");
      }
    }
  }

  init(WebViewController webViewController) {
    _webViewController = webViewController;
    setText(_text);
    setIsHtml(_isHtml);
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
  String initUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var htmlData = MailUtils.wrapInHtmlEditor(
      context,
      "",
      true,
    );
    initUrl = Uri.dataFromString(
      htmlData,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
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

  init() async{
   await _ctrl.loadUrl(initUrl);
    widget.textCtrl.init(_ctrl);
  }
}
