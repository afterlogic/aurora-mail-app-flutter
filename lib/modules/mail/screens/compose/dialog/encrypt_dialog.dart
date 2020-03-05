import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EncryptDialog extends StatefulWidget {
  @override
  _EncryptDialogState createState() => _EncryptDialogState();
}

class _EncryptDialogState extends State<EncryptDialog> {
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _sign = false;
  var _encrypt = true;
  var _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "sign_or_encrypt_tittle")),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(i18n(context, "encrypt")),
                Checkbox(
                  value: _encrypt,
                  onChanged: (bool value) {
                    _encrypt = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(i18n(context, "sign")),
                Checkbox(
                  value: _sign,
                  onChanged: (bool value) {
                    _sign = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            Divider(),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _passCtrl,
                validator: (v) => _sign
                    ? validateInput(context, v, [ValidationType.empty])
                    : null,
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
          child: Text(i18n(context, "sign_or_encrypt")),
          onPressed: _signOrEncrypt,
        ),
      ],
    );
  }

  _signOrEncrypt() {
    if (_formKey.currentState.validate()) {
      Navigator.pop(
        context,
        EncryptDialogResult(_sign, _encrypt, _passCtrl.text),
      );
    }
  }
}

class EncryptDialogResult {
  final bool sign;
  final bool encrypt;
  final String pass;

  EncryptDialogResult(
    this.sign,
    this.encrypt,
    this.pass,
  );
}