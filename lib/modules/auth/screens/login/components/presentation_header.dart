import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

import 'mail_logo.dart';

class PresentationHeader extends StatelessWidget {
  final String appName;

  const PresentationHeader({Key key, this.appName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MailLogo(),
        SizedBox(height: 26.0),
        Text(
          appName,
          style: Theme.of(context).textTheme.display1,
        ),
        SizedBox(height: 12.0),
        Text(
          i18n(context, "login_to_continue"),
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
      ],
    );
  }
}
