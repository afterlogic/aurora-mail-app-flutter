import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData iconForIOS;
  final TextInputType keyboardType;
  final bool isEnabled;
  final bool isPassword;
  final Color visibilityToggleColor;
  final Function(String) validator;

  const AuthInput({
    Key key,
    @required this.controller,
    @required this.label,
    @required this.iconForIOS,
    this.isEnabled = true,
    this.isPassword = false,
    this.keyboardType,
    this.visibilityToggleColor,
    this.validator,
  }) : super(key: key);

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Widget toggleButton = SizedBox(
      height: 50.0,
      child: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: widget.visibilityToggleColor,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );

    if (Platform.isIOS) {
      return CupertinoTextField(
        enabled: widget.isEnabled,
        cursorColor: Theme.of(context).accentColor,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white38))),
        placeholder: widget.label,
        obscureText: widget.isPassword && _obscureText,
        autocorrect: false,
        prefix: Opacity(
          opacity: 0.6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 12.0),
            child: Icon(widget.iconForIOS),
          ),
        ),
        suffix: !widget.isPassword ? null : toggleButton,
      );
    } else {
      return TextFormField(
        enabled: widget.isEnabled,
        cursorColor: Theme.of(context).accentColor,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        obscureText: widget.isPassword && _obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          alignLabelWithHint: true,
          suffixIcon: !widget.isPassword ? null : toggleButton,
        ),
      );
    }
  }
}
