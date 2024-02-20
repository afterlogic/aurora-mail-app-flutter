//@dart=2.9
import 'package:flutter/material.dart';

class ContactDropdown extends StatelessWidget {
  final List<String> options;
  final int primaryValue;
  final void Function(int) onSelected;

  const ContactDropdown(
      {Key key,
      @required this.options,
      @required this.primaryValue,
      @required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      items: options
          .map((o) => DropdownMenuItem(
                value: options.indexOf(o),
                child: Text(o),
              ))
          .toList(),
      underline: SizedBox.shrink(),
      value: primaryValue,
      onChanged: onSelected,
    );
  }
}
