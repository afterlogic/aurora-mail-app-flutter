import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, this.multiLine = false, required this.controller, this.enabled, required this.labelText, this.validator, this.borderColor = const Color(0xFFB6B5B5)});

  final TextEditingController controller;
  final String labelText;
  final Color borderColor;
  final bool? enabled;
  final bool multiLine;
  final String? Function(String?)? validator;
  final borderRadius = 4.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: multiLine ? TextInputType.multiline : null,
      textInputAction: multiLine ? TextInputAction.newline : null,
      minLines: multiLine ? 2 : 1,
      maxLines: multiLine ? 4 : 1,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      label: Text(labelText),
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),

    ),);
  }
}
