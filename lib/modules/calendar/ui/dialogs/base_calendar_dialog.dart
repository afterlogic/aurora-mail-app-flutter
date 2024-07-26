import 'package:flutter/material.dart';

class BaseCalendarDialog extends StatelessWidget {
  const BaseCalendarDialog({super.key, this.title, this.scrollable = true, this.removeContentPadding = false, required this.content, this.actions });

  final String? title;
  final bool removeContentPadding;
  final Widget content;
  final bool scrollable;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: removeContentPadding ? EdgeInsets.zero : null,
      insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      scrollable: scrollable,
      titlePadding:
      EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 0, top: 6),
      actions: actions,
      title: title == null ? null : Row(
        children: [
          Text(title!,
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
