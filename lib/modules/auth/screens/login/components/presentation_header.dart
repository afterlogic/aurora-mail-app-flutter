import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

import 'mail_logo.dart';

class PresentationHeader extends StatelessWidget {
  final String message;
  final String subTitle;

  const PresentationHeader({Key key, this.message, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MailLogo(),
        if (!BuildProperty.useMainLogo) ...[
          SizedBox(height: 26.0),
          Text(
            BuildProperty.appName,
            style: theme.textTheme.headline4,
          ),
          if (subTitle != null) ...[
            SizedBox(height: 12.0),
            Text(
              subTitle,
              style: theme.textTheme.subtitle1,
            ),
          ],
          SizedBox(height: 12.0),
          Text(
            message ?? i18n(context, S.login_to_continue),
            style: TextStyle(color: theme.disabledColor),
          ),
        ]
      ],
    );
  }
}
