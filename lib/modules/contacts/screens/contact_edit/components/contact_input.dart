import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

class ContactInput extends StatelessWidget {
  final int label;
  final TextEditingController ctrl;
  final TextInputType keyboardType;

  const ContactInput(this.label, this.ctrl, {this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: i18n(context, label),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
