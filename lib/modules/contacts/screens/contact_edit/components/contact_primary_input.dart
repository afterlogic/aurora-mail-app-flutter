//@dart=2.9
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

class ContactPrimaryInput<T> extends StatefulWidget {
  final int label;
  final void Function(T) onChanged;
  final T selectedValue;
  final List<String> options;
  final T Function(String) optionsToValue;
  final TextEditingController primaryTextCtrl;
  final TextInputType keyboardType;

  const ContactPrimaryInput(
    this.onChanged,
    this.selectedValue,
    this.label,
    this.options,
    this.optionsToValue,
    this.primaryTextCtrl, {
    this.keyboardType,
    Key key,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: i18n(context, widget.label),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.all(0),
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: DropdownButton<T>(
                items: widget.options
                    .map((o) => DropdownMenuItem(
                          value: widget.optionsToValue(o),
                          child: Text(o),
                        ))
                    .toList(),
                underline: SizedBox.shrink(),
                value: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: textCtrl,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
