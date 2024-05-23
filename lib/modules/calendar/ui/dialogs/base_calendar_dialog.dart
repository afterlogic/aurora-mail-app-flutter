import 'package:flutter/material.dart';

class BaseCalendarDialog extends StatelessWidget {
  const BaseCalendarDialog({super.key, required this.title, required this.content, this.actions });

  final String title;
  final Widget content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding:
      EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 0, top: 6),
      actions: actions,
      title: Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          Spacer(),
          Transform.translate(
            offset: Offset.fromDirection(0, 20),
            child: CloseButton(
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      content: content,

    );
  }
}
