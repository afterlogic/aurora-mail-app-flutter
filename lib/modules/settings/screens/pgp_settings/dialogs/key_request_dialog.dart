//@dart=2.9
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';

class KeyRequestDialog extends StatefulWidget {
  final String pgpKey;

  const KeyRequestDialog(this.pgpKey);

  @override
  State<StatefulWidget> createState() {
    return _KeyRequestDialogState();
  }

  static Future<String> request(BuildContext context, String pgpKey) async {
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
  bool progress = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).label_encryption_password_for_pgp_key),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: formKey,
            child: TextFormField(
              validator: (v) {
                if (v.isEmpty) {
                  return S.of(context).error_password_is_empty;
                }
                if (error != null) {
                  final _error = error;
                  error = null;
                  return _error;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: S.of(context).login_input_password,
                helperText: '',
                suffix: GestureDetector(
                  child: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onTap: () {
                    _obscure = !_obscure;
                    setState(() {});
                  },
                ),
              ),
              controller: passCtrl,
              obscureText: _obscure,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        progress
            ? Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 12),
                child: CircularProgressIndicator(),
              )
            : TextButton(
                child: Text(S.of(context).btn_ok),
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
    setState(() {
      progress = true;
    });
    if (!await AppInjector.instance
        .pgpWorker()
        .checkKeyPassword(widget.pgpKey, passCtrl.text)) {
      error = "Invalid password";
      formKey.currentState.validate();
      setState(() {
        progress = false;
      });
      return;
    }
    Navigator.pop(context, passCtrl.text);
  }
}
