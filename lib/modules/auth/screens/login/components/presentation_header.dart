
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'mail_logo.dart';

class PresentationHeader extends StatelessWidget {
  final String? message;
  final String? subTitle;
  final double logoScale;

  const PresentationHeader({
    Key? key,
    this.message,
    this.subTitle,
    this.logoScale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MailLogo(scale: logoScale),
        if (!BuildProperty.useMainLogo) ...[
          SizedBox(height: 26.0),
          Text(
            BuildProperty.appName,
            style: theme.textTheme.headlineMedium,
          ),
          if (subTitle != null) ...[
            SizedBox(height: 12.0),
            Text(
              subTitle!,
              style: theme.textTheme.titleMedium,
            ),
          ],
          SizedBox(height: 12.0),
          Text(
            message ?? S.of(context).login_to_continue,
            style: TextStyle(color: theme.disabledColor),
          ),
        ]
      ],
    );
  }
}
