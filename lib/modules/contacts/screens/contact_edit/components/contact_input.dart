//@dart=2.9
import 'package:aurora_mail/build_property.dart';
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
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: BuildProperty.useCustomInputStyles
            ? InputDecoration(
                labelText: label,
                filled: true,
                fillColor: Color(0x80F5F5F5), // #F5F5F580
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFFEBEBEB), // #EBEBEB
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFFEBEBEB), // #EBEBEB
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Color(0xFFEBEBEB), // #EBEBEB
                    width: 1.0,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Color(0xFF6F788D), // #6F788D
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              )
            : InputDecoration(
                labelText: label,
                alignLabelWithHint: true,
              ),
      ),
    );
  }
}
