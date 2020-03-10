import 'package:flutter/material.dart';import 'package:aurora_mail/utils/base_state.dart';

class ContactDropdown extends StatelessWidget {
  final List<String> options;
  final int primaryValue;
  final void Function(int) onSelected;

  const ContactDropdown({Key key, @required this.options, @required this.primaryValue, @required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: DropdownButton<int>(
        items: options.map((o) => DropdownMenuItem(
          value: options.indexOf(o),
          child: Text(o),
        )).toList(),
        value: primaryValue,
        onChanged: onSelected,
      ),
    );
  }
}
