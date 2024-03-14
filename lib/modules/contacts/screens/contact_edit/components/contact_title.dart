//@dart=2.9
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const ContactTile(this.title, [this.textStyle]);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ListTile(
        title: Text(
          title,
          style: textStyle ?? theme.textTheme.headline6,
        ),
      ),
    );
  }
}
