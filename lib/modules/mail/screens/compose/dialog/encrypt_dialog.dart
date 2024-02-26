//@dart=2.9
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EncryptDialog extends StatefulWidget {
  @override
  _EncryptDialogState createState() => _EncryptDialogState();
}

class _EncryptDialogState extends BState<EncryptDialog> {
  var _sign = false;
  var _encrypt = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, S.label_pgp_sign_or_encrypt)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(i18n(context, S.btn_pgp_encrypt)),
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
                Text(i18n(context, S.label_pgp_sign)),
                Checkbox(
                  value: _sign,
                  onChanged: (bool value) {
                    _sign = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(i18n(context, S.btn_close)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(i18n(context, S.btn_pgp_sign_or_encrypt)),
          onPressed: _signOrEncrypt,
        ),
      ],
    );
  }

  _signOrEncrypt() {
    Navigator.pop(
      context,
      EncryptDialogResult(_sign, _encrypt),
    );
  }
}

class EncryptDialogResult {
  final bool sign;
  final bool encrypt;

  EncryptDialogResult(
    this.sign,
    this.encrypt,
  );
}
