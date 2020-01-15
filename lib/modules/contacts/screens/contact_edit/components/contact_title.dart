import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactTitle extends StatelessWidget {
  final String title;

  const ContactTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        i18n(context, title),
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}