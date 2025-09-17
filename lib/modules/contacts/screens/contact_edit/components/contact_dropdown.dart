//@dart=2.9
import 'package:aurora_mail/utils/input_utils.dart';
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return InputUtils.buildUnlymeDropdown<int>(
      value: primaryValue,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      items: List.generate(options.length, (index) => index),
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
      itemBuilder: (index) => options[index],
    );
  }
}
