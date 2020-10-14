import 'dart:io';

import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ComposeSubject extends StatefulWidget {
  final TextEditingController textCtrl;
  final Function(FileType type) onAttach;
  final FocusNode focusNode;
  final VoidCallback onNext;

  const ComposeSubject({
    Key key,
    @required this.textCtrl,
    @required this.onAttach,
    this.focusNode,
    this.onNext,
  }) : super(key: key);

  @override
  _ComposeSubjectState createState() => _ComposeSubjectState();
}

class _ComposeSubjectState extends BState<ComposeSubject> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.focusNode.requestFocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(i18n(context, S.messages_subject),
                  style: theme.textTheme.subhead),
            ),
            SizedBox(width: 8.0),
            Flexible(
              flex: 1,
              child: Wrap(spacing: 8.0, children: [
                TextField(
                  onTap: null,
                  focusNode: widget.focusNode,
                  controller: widget.textCtrl,
                  decoration: InputDecoration.collapsed(
                    hintText: null,
                  ),
                  onEditingComplete: widget.onNext,
                ),
              ]),
            ),
            IconButton(
              icon: Icon(Icons.attachment),
              padding: EdgeInsets.zero,
              color: theme.accentColor,
              onPressed: () => widget.onAttach(FileType.any),
            ),
            if (Platform.isIOS)
              IconButton(
                icon: Icon(Icons.perm_media),
                padding: EdgeInsets.zero,
                color: theme.accentColor,
                onPressed: () => widget.onAttach(FileType.media),
              ),
          ],
        ),
      ),
    );
  }
}
