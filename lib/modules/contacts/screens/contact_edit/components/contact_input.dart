import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactInput extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;

  const ContactInput(this.label, this.ctrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: i18n(context, label),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
