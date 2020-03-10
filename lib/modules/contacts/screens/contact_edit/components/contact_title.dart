import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class ContactTitle extends StatelessWidget {
  final String title;

  const ContactTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return ListTile(
      title: Text(
        i18n(context, title),
        style: theme.textTheme.title,
      ),
    );
  }
}
