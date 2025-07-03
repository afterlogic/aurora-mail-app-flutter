import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

class MessageHeaders extends StatelessWidget {
  final String text;

  const MessageHeaders(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(S.of(context).label_message_headers),
        backgroundColor: AppColor.appBarBackground,
        shadow: BoxShadow(color: Colors.transparent),
      ),
      body: Column(
        children: [
          if (BuildProperty.useAppBarDivider) Divider(height: 1),
          Expanded(
            child: Padding(
              child: SelectableText(text),
              padding: EdgeInsets.all(16),
            ),
          ),
        ],
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
