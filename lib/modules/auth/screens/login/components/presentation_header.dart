import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

import 'mail_logo.dart';

class PresentationHeader extends StatelessWidget {
  final String message;

  const PresentationHeader({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MailLogo(),
        if (!BuildProperty.useMainLogo) ...[
          SizedBox(height: 26.0),
          Text(
            BuildProperty.appName,
            style: theme.textTheme.display1,
          ),
          SizedBox(height: 12.0),
          Text(
            message ?? i18n(context, "login_to_continue"),
            style: TextStyle(color: theme.disabledColor),
          ),
        ]
      ],
    );
  }
}
