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
  final String Function(String) validator;

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

    if (Platform.isIOS) {
      return CupertinoTextField(
        enabled: widget.isEnabled,
        style: TextStyle(color: Colors.black),
        cursorColor: Theme.of(context).accentColor,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        placeholder: widget.label,
        obscureText: widget.isPassword && _obscureText,
        autocorrect: false,
        prefix: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Icon(widget.iconForIOS, color: Colors.black38),
        ),
        suffix: widget.isPassword ? CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: widget.visibilityToggleColor ?? Colors.black38,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ) : null,
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
          suffixIcon: widget.isPassword ? SizedBox(
            height: 50.0,
            child: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: widget.visibilityToggleColor ?? Theme.of(context).iconTheme.color,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
          ) : null,
        ),
      );
    }
  }
}
