import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactTitle extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const ContactTitle(this.title, [this.textStyle]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ListTile(
        title: Text(
          i18n(context, title),
          style: textStyle ?? theme.textTheme.title,
        ),
      ),
    );
  }
}
