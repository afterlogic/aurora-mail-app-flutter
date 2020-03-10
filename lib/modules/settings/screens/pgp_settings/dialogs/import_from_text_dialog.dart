import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class ImportFromTextDialog extends StatefulWidget {
  @override
  _ImportFromTextDialogState createState() => _ImportFromTextDialogState();
}

class _ImportFromTextDialogState extends BState<ImportFromTextDialog> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "import_key")),
      content: SizedDialogContent(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(7),
          ),
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              validator: (v) => validateInput(context, v, [
                ValidationType.empty,
              ]),
              expands: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "check_keys")),
          onPressed: () => _checkText(context),
        )
      ],
    );
  }

  _checkText(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, _textController.text);
    }
  }
}
