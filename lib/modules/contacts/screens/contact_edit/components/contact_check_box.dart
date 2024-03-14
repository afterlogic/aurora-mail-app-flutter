//@dart=2.9
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
      title: Text(label),
      value: value,
      onChanged: onEdit,
    );
  }
}
