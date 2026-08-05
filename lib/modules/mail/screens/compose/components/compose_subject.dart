
import 'dart:io';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ComposeSubject extends StatefulWidget {
  final TextEditingController textCtrl;
  final Function(FileType type) onAttach;
  final FocusNode? focusNode;
  final VoidCallback? onNext;

  const ComposeSubject({
    Key? key,
    required this.textCtrl,
    required this.onAttach,
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
    return GestureDetector(
      onTap: widget.focusNode!.requestFocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: InputUtils.buildUnlymeTextField(
                controller: widget.textCtrl,
                labelText: S.of(context).messages_subject,
                focusNode: widget.focusNode,
                onEditingComplete: widget.onNext,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.attachment),
                      padding: EdgeInsets.zero,
                      color: theme.primaryColor,
                      onPressed: () => widget.onAttach(FileType.any),
                    ),
                    if (Platform.isIOS)
                      IconButton(
                        icon: Icon(Icons.perm_media),
                        padding: EdgeInsets.zero,
                        color: theme.primaryColor,
                        onPressed: () => widget.onAttach(FileType.media),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
