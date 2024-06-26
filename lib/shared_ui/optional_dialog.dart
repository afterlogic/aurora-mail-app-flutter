//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class OptionalDialogResult {
  final bool generalResult;
  final Map<String, bool> options;

  OptionalDialogResult({this.generalResult, this.options});
}

class OptionalDialog extends StatefulWidget {
  final String title;
  final String description;
  final Map<String, bool> options;
  final String actionText;
  final List<Widget> actions;

  const OptionalDialog({
    Key key,
    this.title,
    this.description,
    @required this.options,
    @required this.actionText,
    this.actions,
  }) : super(key: key);

  static Future<OptionalDialogResult> showWithOptions(
      BuildContext context,
      String title,
      String description,
      Map<String, bool> options,
      String actionText, {
        List<Widget> actions,
      }) {
    return dialog(
        context: context,
        builder: (_) => OptionalDialog(
          title: title,
          description: description,
          options: options,
          actionText: actionText,
          actions: actions,
        )).then((value) => ( value as OptionalDialogResult) ?? null);
  }

  static Future<bool> show(
    BuildContext context,
    String title,
    String description,
    Map<String, bool> options,
    String actionText, {
    List<Widget> actions,
  }) {
    return dialog(
        context: context,
        builder: (_) => OptionalDialog(
              title: title,
              description: description,
              options: options,
              actionText: actionText,
              actions: actions,
            )).then((value) => (value as bool) ?? false);
  }

  @override
  _OptionalDialogState createState() => _OptionalDialogState();
}

class _OptionalDialogState extends State<OptionalDialog> {
  String title;
  String description;
  Map<String, bool> options;
  String actionText;
  List<Widget> actions;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.description;
    options = widget.options;
    actionText = widget.actionText;
    actions = widget.actions;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      if (description != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(description),
        )
    ];
    for (final key in options.keys) {
      final row = GestureDetector(
        onTap: () => _onTapOption(key),
        child: Row(
          children: [
            Checkbox(
              value: options[key],
              onChanged: (_) => _onTapOption(key),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(key),
              ),
            ),
          ],
        ),
      );

      children.add(row);
    }
    return AlertDialog(
      title: title == null ? null : Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(
            context,
            OptionalDialogResult(generalResult: false, options: options),
          ),
        ),
        if (actions != null) ...actions,
        TextButton(
          child: Text(actionText),
          onPressed: () => Navigator.pop(
            context,
            OptionalDialogResult(generalResult: true, options: options),
          ),
        ),
      ],
    );
  }

  void _onTapOption(String key) {
    setState(() {
      options[key] = !options[key];
    });
  }
}
