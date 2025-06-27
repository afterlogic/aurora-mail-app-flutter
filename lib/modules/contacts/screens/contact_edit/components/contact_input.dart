//@dart=2.9
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:flutter/material.dart';

class ContactInput extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final TextInputType keyboardType;

  const ContactInput(this.label, this.ctrl, {this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InputUtils.buildUnlymeTextFormField(
        controller: ctrl,
        labelText: label,
        keyboardType: keyboardType,
      ),
    );
  }
}
