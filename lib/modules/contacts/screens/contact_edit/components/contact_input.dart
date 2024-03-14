//@dart=2.9
import 'package:flutter/material.dart';

class ContactInput extends StatelessWidget {
  final String label;
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
          labelText: label,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
