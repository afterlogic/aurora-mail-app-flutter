import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class RequestPasswordDialog extends StatefulWidget {
  @override
  _RequestPasswordDialogState createState() => _RequestPasswordDialogState();
}

class _RequestPasswordDialogState extends BState<RequestPasswordDialog> {
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "decrypt_title")),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _passCtrl,
                validator: (v) =>
                    validateInput(context, v, [ValidationType.empty]),
                decoration: InputDecoration(
                    labelText: i18n(context, "login_input_password"),
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePass ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _obscurePass = !_obscurePass;
                        setState(() {});
                      },
                    )),
                obscureText: _obscurePass,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "close")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "decrypt")),
          onPressed: _decrypt,
        ),
      ],
    );
  }

  _decrypt() {
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, RequestPasswordDialogResult(_passCtrl.text));
    }
  }
}

class RequestPasswordDialogResult {
  final String pass;

  RequestPasswordDialogResult(this.pass);
}
