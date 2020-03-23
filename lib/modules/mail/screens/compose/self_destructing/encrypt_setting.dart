import 'dart:math';

import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/self_destructing_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/components/contact_with_key_widget.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_model/src/pgp_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/life_time.dart';

class EncryptSetting extends StatefulWidget {
  final SelfDestructingBloc bloc;
  final String contacts;

  EncryptSetting(this.bloc, this.contacts);

  @override
  _EncryptSettingState createState() => _EncryptSettingState();
}

class _EncryptSettingState extends BState<EncryptSetting> {
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LifeTime lifeTime = LifeTime.values.first;
  bool hasPrivateKey = false;
  bool useSign = false;
  bool isKeyBased = false;
  bool obscure = false;

  @override
  void initState() {
    widget.bloc.add(LoadKey(widget.contacts));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SelfDestructingBloc, SelfDestructingState>(
      child: BlocBuilder<SelfDestructingBloc, SelfDestructingState>(
          condition: (_, state) => state is LoadedKey,
          builder: (context, state) {
            if (state is LoadedKey) {
              final hasKey = state.key != null;
              final contacts = state.contacts;
              final recipientHaveKey = contacts.firstWhere(
                    (item) => item.key == null,
                    orElse: () => null,
                  ) ==
                  null;
              return AlertDialog(
                title: Text(i18n(context, "send_self_destructing_title")),
                content: SizedBox(
                  height: min(size.height / 2, 350),
                  width: min(size.width - 40, 300),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        "OpenPGP supports plain text only. Click OK to remove all the formatting and continue. Also, attachments cannot be encrypted or signed.",
                        style: theme.textTheme.caption,
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: contacts.map((item) => ContactWithKeyWidget(item)).toList(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        i18n(context,
                            recipientHaveKey ? "encrypt_with_key" : "encrypt_with_not_key"),
                        style: theme.textTheme.caption,
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<LifeTime>(
                        decoration: InputDecoration(
                          labelText: i18n(context, "message_lifetime"),
                        ),
                        value: lifeTime,
                        items: LifeTime.values.map((value) {
                          return DropdownMenuItem<LifeTime>(
                            value: value,
                            child: Text(i18n(context, value.toText())),
                          );
                        }).toList(),
                        isExpanded: true,
                        onChanged: (LifeTime v) {
                          lifeTime = v;
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        title: Text(i18n(context, "password_based_encryption")),
                        value: false,
                        onChanged: (bool value) {
                          isKeyBased = value;
                          setState(() {});
                        },
                        groupValue: isKeyBased,
                      ),
                      RadioListTile(
                        title: Text(i18n(context, "key_based_encryption")),
                        value: true,
                        groupValue: isKeyBased,
                        onChanged: !recipientHaveKey
                            ? null
                            : (bool value) {
                                isKeyBased = value;
                                setState(() {});
                              },
                      ),
                      SizedBox(height: 10),
                      Text(
                        i18n(
                            context,
                            isKeyBased
                                ? "key_based_encryption_used"
                                : "password_based_encryption_used"),
                        style: theme.textTheme.caption,
                      ),
                      SizedBox(height: 10),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(i18n(context, "add_digital_signature")),
                        value: useSign,
                        onChanged: hasKey && isKeyBased
                            ? (v) {
                                useSign = !useSign;
                                setState(() {});
                              }
                            : null,
                      ),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          enabled: useSign,
                          controller: passwordCtrl,
                          obscureText: obscure,
                          validator: (text) => validateInput(context, text, [ValidationType.empty]),
                          decoration: InputDecoration(
                            labelText: i18n(context, "login_input_password"),
                            suffix: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                              ),
                              onTap: () {
                                obscure = !obscure;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        i18n(context, useSign ? "sign_data" : "not_sign_data"),
                        style: theme.textTheme.caption,
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(i18n(context, "btn_cancel")),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text(i18n(context, "encrypt")),
                    onPressed: () => create(contacts),
                  )
                ],
              );
            } else {
              return SizedBox.fromSize(
                size: size,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
      listener: (BuildContext context, SelfDestructingState state) {
        if (state is Encrypted || state is ErrorState) {
          Navigator.pop(context, state);
        }
      },
    );
  }

  void create(List<ContactWithKey> contacts) {
    if (!useSign || formKey.currentState.validate()) {
      final bloc = BlocProvider.of<SelfDestructingBloc>(context);
      bloc.add(
        EncryptEvent(
          lifeTime,
          isKeyBased,
          useSign,
          passwordCtrl.text,
          contacts.map((item) => item.contact.viewEmail).toList(),
        ),
      );
    }
  }
}

class EncryptSettingResult {
  final LifeTime lifeTime;
  final bool useKey;
  final bool useSign;
  final String password;

  EncryptSettingResult(this.lifeTime, this.useKey, this.useSign, this.password);
}
