import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageHeaders extends StatelessWidget {
  final String text;

  const MessageHeaders(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, S.label_message_headers)),
      ),
      body: Padding(
        child: SelectableText(text),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}

class MessageHeadersRoute {
  static const name = "MessageHeadersRoute";
}

class MessageHeadersRouteArg {
  final String text;

  MessageHeadersRouteArg(this.text);
}
