import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenerateKeyDialog extends StatefulWidget {
  final List<String> mails;
  final String current;

  const GenerateKeyDialog(this.mails, this.current);

  @override
  _GenerateKeyDialogState createState() => _GenerateKeyDialogState();
}

class _GenerateKeyDialogState extends State<GenerateKeyDialog> {
  static const lengths = [1024, 2048, 3072, 4096, 8192];
  var length = lengths[1];
  String mail;
  bool _obscure = true;

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    mail = widget.mails.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "generate_keys")),
      content: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
              hint: Text(length.toString()),
              decoration: InputDecoration(
                  labelText: i18n(context, "login_input_email")),
              value: mail,
              items: widget.mails.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String v) {
                mail = v;
                setState(() {});
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: i18n(context, "login_input_password"),
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
              validator: (v) =>
                  validateInput(context, v, [ValidationType.empty]),
              controller: _passwordController,
              obscureText: _obscure,
            ),
            DropdownButtonFormField(
              hint: Text(length.toString()),
              decoration: InputDecoration(labelText: i18n(context, "length")),
              value: length,
              items: lengths.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                  ),
                );
              }).toList(),
              onChanged: (int v) {
                length = v;
                setState(() {});
              },
            ),
          ],
        ),
      )),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "close")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "generate")),
          onPressed: _generate,
        )
      ],
    );
  }

  _generate() {
    if (_formKey.currentState.validate()) {
      final length = this.length;
      final mail = this.mail;
      final pass = _passwordController.text;
      Navigator.pop(context, GenerateKeyDialogResult(length, mail, pass));
    }
  }
}

class GenerateKeyDialogResult {
  final int length;
  final String mail;
  final String password;

  GenerateKeyDialogResult(this.length, this.mail, this.password);
}
