
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme/login_form_style.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool isEnabled;
  final bool isPassword;
  final Color? visibilityToggleColor;
  final String? Function(String?)? validator;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter>? inputFormatters;

  const AuthInput({
    Key? key,
    required this.controller,
    required this.label,
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
    // Brand-defined look of the sign-in fields; falls back to the historical
    // hard-coded values if a brand's theme does not register the extension.
    final style = theme.extension<LoginFormStyle>() ?? LoginFormStyle.fallback;
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(style.fieldRadius),
      borderSide: BorderSide(color: style.fieldBorderColor),
    );

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscureText,
      style: style.fieldTextStyle,
      cursorColor: style.fieldCursorColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: style.fieldFillColor,
        contentPadding: style.fieldContentPadding,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: style.fieldFocusedBorderColor),
        ),
        errorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: style.fieldErrorBorderColor),
        ),
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: BorderSide(color: style.fieldErrorBorderColor),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.label,
        hintStyle: style.fieldHintStyle,
        suffixIcon: widget.isPassword
            ? SizedBox(
                height: 50.0,
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: widget.visibilityToggleColor ??
                        style.visibilityToggleColor ??
                        theme.iconTheme.color,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              )
            : null,
      ),
    );
  }
}
