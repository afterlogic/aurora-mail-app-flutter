import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

class KeyRequestDialog extends StatefulWidget {
  final String pgpKey;

  const KeyRequestDialog(this.pgpKey);

  @override
  State<StatefulWidget> createState() {
    return _KeyRequestDialogState();
  }

  static Future<String> request(
      BuildContext context, String pgpKey) async {
    final password = await showDialog<String>(
      context: context,
      builder: (context) {
        return KeyRequestDialog(pgpKey);
      },
    );
    return password;
  }
}

class InvalidKeyPassword extends Error {
  @override
  String toString() {
    return "Invalid password";
  }
}

class _KeyRequestDialogState extends BState<KeyRequestDialog> {
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "label_encryption_password_for_pgp_key")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: formKey,
            child: TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return i18n(context, "error_password_is_empty");
                }
                if (error != null) {
                  final _error = error;
                  error = null;
                  return _error;
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: i18n(context, "login_input_password")),
              controller: passCtrl,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_ok")),
          onPressed: () {
            if (formKey.currentState.validate()) {
              _check();
            }
          },
        )
      ],
    );
  }

  _check() async {
    if (!await AppInjector.instance
        .pgpWorker()
        .checkKeyPassword(widget.pgpKey, passCtrl.text)) {
      error = "Invalid password";
      formKey.currentState.validate();
      return;
    }
    Navigator.pop(context, passCtrl.text);
  }
}
