import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ComposeSubject extends StatefulWidget {
  final TextEditingController textCtrl;
  final Function() onAttach;

  const ComposeSubject(
      {Key key, @required this.textCtrl, @required this.onAttach})
      : super(key: key);

  @override
  _ComposeSubjectState createState() => _ComposeSubjectState();
}

class _ComposeSubjectState extends BState<ComposeSubject> {
  var _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: _focusNode.requestFocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(i18n(context, "messages_subject"),
                  style: theme.textTheme.subhead),
            ),
            SizedBox(width: 8.0),
            Flexible(
              flex: 1,
              child: Wrap(spacing: 8.0, children: [
                TextField(
                  onTap: null,
                  focusNode: _focusNode,
                  controller: widget.textCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: null,
                  ),
                ),
              ]),
            ),
            IconButton(
              icon: Icon(Icons.attachment),
              padding: EdgeInsets.zero,
              color: theme.accentColor,
              onPressed: widget.onAttach,
            ),
          ],
        ),
      ),
    );
  }
}
