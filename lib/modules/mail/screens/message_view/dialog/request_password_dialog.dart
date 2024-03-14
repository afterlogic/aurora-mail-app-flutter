//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
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
      title: Text(S.of(context).label_pgp_decrypt),
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
                    labelText: S.of(context).login_input_password,
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
        TextButton(
          child: Text(S.of(context).btn_close),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(S.of(context).btn_pgp_decrypt),
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
