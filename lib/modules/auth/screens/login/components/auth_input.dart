import 'package:aurora_mail/build_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isEnabled;
  final bool isPassword;
  final Color visibilityToggleColor;
  final String Function(String) validator;

  const AuthInput({
    Key key,
    @required this.controller,
    @required this.label,
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
    return TextFormField(
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscureText,
      decoration: InputDecoration(
        hasFloatingPlaceholder: BuildProperty.hasFloatingPlaceholder,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).disabledColor.withOpacity(0.1))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor)),
        hintText: BuildProperty.hasFloatingPlaceholder ? null : widget.label,
        labelText: BuildProperty.hasFloatingPlaceholder ? widget.label : null,
        suffixIcon: widget.isPassword
            ? SizedBox(
                height: 50.0,
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: widget.visibilityToggleColor ??
                        Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              )
            : null,
      ),
    );
  }
}
