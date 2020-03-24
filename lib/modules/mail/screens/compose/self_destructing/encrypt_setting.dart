import 'dart:math';

import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/self_destructing_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/components/contact_with_key_widget.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/shared_ui/toast_widget.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:crypto_model/src/pgp_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

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
  final toastKey = GlobalKey<ToastWidgetState>();
  LifeTime lifeTime = LifeTime.values.first;
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
              final contact = state.contact;
              final recipientHaveKey = contact.key != null;
              return AlertDialog(
                title: Text(i18n(context, "send_self_destructing_title")),
                content: SizedBox(
                  height: min(size.height / 2, 350),
                  width: min(size.width - 40, 300),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          Text(
                            i18n(context, "supports_plain_text_only"),
                            style: theme.textTheme.caption,
                          ),
                          SizedBox(height: 20),
                          ContactWithKeyWidget(contact),
                          SizedBox(height: 20),
                          Text(
                            i18n(
                                context,
                                recipientHaveKey
                                    ? "encrypt_with_key"
                                    : "encrypt_with_not_key"),
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
                            selectedItemBuilder: (context) {
                              return LifeTime.values.map((value) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(i18n(context, value.toText())),
                                );
                              }).toList();
                            },
                            isExpanded: true,
                            onChanged: (LifeTime v) {
                              lifeTime = v;
                              setState(() {});
                            },
                          ),
                          RadioListTile(
                            title: Text(
                                i18n(context, "password_based_encryption")),
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
                            onChanged: hasKey && recipientHaveKey
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
                              validator: (text) => validateInput(
                                  context, text, [ValidationType.empty]),
                              decoration: InputDecoration(
                                labelText:
                                    i18n(context, "login_input_password"),
                                suffix: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(obscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
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
                            i18n(context,
                                useSign ? "sign_data" : "not_sign_data"),
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      Center(
                        child: ToastWidget(
                          key: toastKey,
                        ),
                      )
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
                  BlocBuilder<SelfDestructingBloc, SelfDestructingState>(
                    builder: (context, state) => FlatButton(
                      child: state is! ProgressState
                          ? Text(i18n(context, "encrypt"))
                          : CircularProgressIndicator(),
                      onPressed: state is! ProgressState
                          ? () => create(contact)
                          : null,
                    ),
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
        if (state is ErrorState) {
          toastKey.currentState.show(i18n(context, state.message));
        } else if (state is Encrypted) {
          Navigator.pop(context, state);
        }
      },
    );
  }

  void create(ContactWithKey contact) {
    if (!useSign || formKey.currentState.validate()) {
      final contactName = contact.contact.fullName?.isNotEmpty == true
          ? contact.contact.fullName
          : contact.contact.viewEmail;
      var dateTime = Instant.now();

      final now =
          dateTime.inZone(DateTimeZone.local).toString('MMM dd, yyyy HH:mm z') +
              DateTimeZone.local.getUtcOffset(dateTime).toString();

      final passwordText = !isKeyBased&&contact.key != null
          ? i18n(context, "self_destructing_message_password")
          : "";
      final lifeTimeText = i18n(context, lifeTime.toText());

      final viewBody = i18n(
        context,
        "self_destructing_message_template",
        {
          "contactName": contactName,
          "message_password": passwordText,
          "lifeTime": lifeTimeText,
          "now": now
        },
      );

      final bloc = BlocProvider.of<SelfDestructingBloc>(context);
      bloc.add(
        EncryptEvent(
          lifeTime,
          isKeyBased,
          useSign,
          passwordCtrl.text,
          contact,
          viewBody,
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
