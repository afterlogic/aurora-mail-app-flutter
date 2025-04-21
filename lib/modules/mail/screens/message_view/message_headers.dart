import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

class MessageHeaders extends StatelessWidget {
  final String text;

  const MessageHeaders(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(S.of(context).label_message_headers),
        backgroundColor: Color(0xFFF4F1FD),
        textStyle:TextStyle(color: Color(0xFF2D2D2D), fontSize: 18, fontWeight: FontWeight.w600),
        shadow: BoxShadow(color: Colors.transparent),
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
