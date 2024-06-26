//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isEnabled;
  final bool isPassword;
  final Color visibilityToggleColor;
  final String Function(String) validator;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter> inputFormatters;

  const AuthInput({
    Key key,
    @required this.controller,
    @required this.label,
    this.isEnabled = true,
    this.isPassword = false,
    this.keyboardType,
    this.visibilityToggleColor,
    this.validator,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _AuthInputState createState() => _AuthInputState();
}

class _AuthInputState extends BState<AuthInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscureText,
      decoration: InputDecoration(
        // floatingLabelBehavior: BuildProperty.hasFloatingPlaceholder,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: theme.disabledColor.withOpacity(0.1))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor)),
        // hintText: BuildProperty.hasFloatingPlaceholder ? null : widget.label,
        // labelText: BuildProperty.hasFloatingPlaceholder ? widget.label : null,
        hintText: false ? null : widget.label,
        labelText: false ? widget.label : null,
        suffixIcon: widget.isPassword
            ? SizedBox(
                height: 50.0,
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color:
                        widget.visibilityToggleColor ?? theme.iconTheme.color,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              )
            : null,
      ),
    );
  }
}
