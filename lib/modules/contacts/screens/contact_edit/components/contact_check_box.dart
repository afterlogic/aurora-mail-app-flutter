import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ContactCheckBox extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onEdit;

  const ContactCheckBox(
    this.label,
    this.value,
    this.onEdit,
  );

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(i18n(context, label)),
      value: value,
      onChanged: onEdit,
    );
  }
}
