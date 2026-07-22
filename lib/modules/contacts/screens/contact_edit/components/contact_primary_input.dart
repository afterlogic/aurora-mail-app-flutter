
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:flutter/material.dart';

class ContactPrimaryInput<T> extends StatefulWidget {
  final String label;
  final void Function(T) onChanged;
  final T selectedValue;
  final List<String> options;
  final T Function(String) optionsToValue;
  final TextEditingController primaryTextCtrl;
  final TextInputType? keyboardType;

  const ContactPrimaryInput(
    this.onChanged,
    this.selectedValue,
    this.label,
    this.options,
    this.optionsToValue,
    this.primaryTextCtrl, {
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  _ContactPrimaryInputState createState() => _ContactPrimaryInputState<T>();
}

class _ContactPrimaryInputState<T> extends State<ContactPrimaryInput<T>> {
  final textCtrl = TextEditingController();
  bool lock = false;

  listenTextInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textCtrl.text = widget.primaryTextCtrl.text;
      widget.primaryTextCtrl.addListener(_onPrimaryTextChange);
    });
  }

  _onTextChange() {
    if (!lock) {
      lock = true;
      widget.primaryTextCtrl.text = textCtrl.text;
      lock = false;
    }
  }

  _onPrimaryTextChange() {
    if (!lock) {
      lock = true;
      textCtrl.text = widget.primaryTextCtrl.text;
      lock = false;
    }
  }

  @override
  initState() {
    super.initState();
    textCtrl.addListener(_onTextChange);
    listenTextInput();
  }

  @override
  void didUpdateWidget(ContactPrimaryInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.primaryTextCtrl != widget.primaryTextCtrl) {
      oldWidget.primaryTextCtrl.removeListener(_onPrimaryTextChange);
      listenTextInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return InputUtils.buildUnlymePrimaryInput<T>(
      label: widget.label,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      onChanged: (value) {
        if (value != null) widget.onChanged(value);
      },
      selectedValue: widget.selectedValue,
      options: widget.options,
      optionsToValue: widget.optionsToValue,
      primaryTextCtrl: textCtrl,
      keyboardType: widget.keyboardType,
    );
  }
}
