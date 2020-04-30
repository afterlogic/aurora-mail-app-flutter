import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora_mail/utils/base_state.dart';

class GenerateKeyDialog extends StatefulWidget {
  final List<AliasOrIdentity> identities;
  final AliasOrIdentity current;

  const GenerateKeyDialog(this.identities, this.current);

  @override
  _GenerateKeyDialogState createState() => _GenerateKeyDialogState();
}

class _GenerateKeyDialogState extends BState<GenerateKeyDialog> {
  static const lengths = [ 2048,  4096];
  var length = lengths[1];
  AliasOrIdentity current;
  bool _obscure = true;

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    current = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "btn_pgp_generate_keys")),
      content: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            DropdownButtonFormField(
              decoration: InputDecoration(
                  labelText: i18n(context, "login_input_email")),
              value: current,
              items: widget.identities.map((value) {
                return DropdownMenuItem<AliasOrIdentity>(
                  value: value,
//                  child: Text(identityViewName(value.name, value.mail)),
                  child: _buildEmails(value),
                );
              }).toList(),
              isExpanded: true,
              selectedItemBuilder: (_) {
                return widget.identities.map((value) {
                  return Text(
                    IdentityView.solid(value.name, value.mail),
                    maxLines: 2,
                  );
                }).toList();
              },
              onChanged: (AliasOrIdentity v) {
                current = v;
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
              decoration: InputDecoration(labelText: i18n(context, "label_length")),
              value: length,
              items: lengths.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (context) {
                return lengths.map((value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(value.toString()),
                  );
                }).toList();
              },
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
          child: Text(i18n(context, "btn_close")),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, "btn_pgp_generate")),
          onPressed: _generate,
        )
      ],
    );
  }

  Widget _buildEmails(AliasOrIdentity value) {
    final padding = widget.identities.last == value ? 0.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value.name != null && value.name.isNotEmpty) Text(value.name),
        if (value.mail != null && value.mail.isNotEmpty) Text(value.mail),
        SizedBox(height: padding),
      ],
    );
  }

  _generate() {
    if (_formKey.currentState.validate() && current != null) {
      final pass = _passwordController.text;

      Navigator.pop(context, GenerateKeyDialogResult(length, current, pass));
    }
  }
}

class GenerateKeyDialogResult {
  final int length;
  final AliasOrIdentity alias;
  final String password;

  GenerateKeyDialogResult(this.length, this.alias, this.password);
}
