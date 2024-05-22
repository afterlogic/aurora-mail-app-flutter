import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.controller, required this.labelText, this.borderColor = const Color(0xFFB6B5B5)});

  final TextEditingController controller;
  final String labelText;
  final Color borderColor;
  final borderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),

      label: Text(labelText),
      hintText: 'Enter your name',
      isDense: true,
      labelStyle: TextStyle(color: borderColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),

      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),);
  }
}