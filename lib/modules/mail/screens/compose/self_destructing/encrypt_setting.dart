//@dart=2.9
import 'dart:math';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/components/contact_with_key_widget.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/model/contact_with_key.dart';
import 'package:aurora_mail/shared_ui/toast_widget.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/input_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_machine/time_machine.dart';

import 'model/life_time.dart';

class EncryptSetting extends StatefulWidget {
  final SelfDestructingBloc bloc;
  final String contact;

  EncryptSetting(this.bloc, this.contact);

  @override
  _EncryptSettingState createState() => _EncryptSettingState();
}

class _EncryptSettingState extends BState<EncryptSetting>
    with NotSavedChangesMixin {
  final passwordCtrl = TextEditingController();
  final scroll = ScrollController();
  final formKey = GlobalKey<FormState>();
  final toastKey = GlobalKey<ToastWidgetState>();
  LifeTime lifeTime = LifeTime.values.first;
  bool useSign = false;
  bool isKeyBased = false;
  bool obscure = false;

  @override
  void initState() {
    widget.bloc.add(LoadKey(widget.contact));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SelfDestructingBloc, SelfDestructingState>(
      child: BlocBuilder<SelfDestructingBloc, SelfDestructingState>(
          buildWhen: (_, state) => state is LoadedKey,
          builder: (context, state) {
            if (state is LoadedKey) {
              final sender = state.sender;
              final hasKey = sender.key != null;

              final contact = state.contact;
              final recipientHaveKey = contact.key != null;
              return AlertDialog(
                title: Text(S.of(context).label_self_destructing),
                content: SizedBox(
                  height: min(size.height / 2, 350),
                  width: min(size.width - 40, 300),
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        controller: scroll,
                        padding: EdgeInsets.all(0),
                        children: <Widget>[
                          Text(
                            S
                                .of(context)
                                .hint_self_destructing_supports_plain_text_only,
                            style: theme.textTheme.caption,
                          ),
                          SizedBox(height: 20),
                          ContactWithKeyWidget(contact),
                          SizedBox(height: 20),
                          Text(
                            recipientHaveKey
                                ? S
                                    .of(context)
                                    .hint_self_destructing_encrypt_with_key
                                : S
                                    .of(context)
                                    .hint_self_destructing_encrypt_with_not_key,
                            style: theme.textTheme.caption,
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField<LifeTime>(
                            decoration: InputDecoration(
                              labelText: S.of(context).message_lifetime,
                            ),
                            value: lifeTime,
                            items: LifeTime.values.map((value) {
                              return DropdownMenuItem<LifeTime>(
                                value: value,
                                child: Text(value.toText(context)),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return LifeTime.values.map((value) {
                                return Text(value.toText(context));
                              }).toList();
                            },
                            isExpanded: true,
                            onChanged: (LifeTime v) {
                              lifeTime = v;
                              setState(() {});
                            },
                          ),
                          RadioListTile(
                            title: Text(S
                                .of(context)
                                .input_self_destructing_password_based_encryption),
                            value: false,
                            onChanged: (bool value) {
                              isKeyBased = value;
                              useSign = false;
                              setState(() {});
                            },
                            groupValue: isKeyBased,
                          ),
                          RadioListTile(
                            title: Text(S
                                .of(context)
                                .input_self_destructing_key_based_encryption),
                            value: true,
                            groupValue: isKeyBased,
                            onChanged: !recipientHaveKey
                                ? null
                                : (bool value) {
                                    isKeyBased = value;
                                    useSign = value && hasKey;
                                    setState(() {});
                                  },
                          ),
                          SizedBox(height: 10),
                          Text(
                            isKeyBased
                                ? S
                                    .of(context)
                                    .label_self_destructing_key_based_encryption_used
                                : S
                                    .of(context)
                                    .label_self_destructing_password_based_encryption_used,
                            style: theme.textTheme.caption,
                          ),
                          SizedBox(height: 10),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(S
                                .of(context)
                                .input_self_destructing_add_digital_signature),
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
                              validator: (text) => validateInput(
                                  context, text, [ValidationType.empty]),
                              decoration: InputDecoration(
                                labelText: S.of(context).login_input_password,
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
                            useSign
                                ? S.of(context).label_self_destructing_sign_data
                                : S
                                    .of(context)
                                    .label_self_destructing_not_sign_data,
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
                  TextButton(
                    child: Text(S.of(context).btn_cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  BlocBuilder<SelfDestructingBloc, SelfDestructingState>(
                    builder: (context, state) => TextButton(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(S.of(context).btn_pgp_encrypt),
                          state is ProgressState
                              ? CircularProgressIndicator()
                              : SizedBox.shrink(),
                        ],
                      ),
                      onPressed: state is! ProgressState
                          ? () => create(contact, sender)
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
          toastKey.currentState.show(state.message.getString());
        } else if (state is Encrypted) {
          Navigator.pop(context, state);
        }
      },
    );
  }

  void create(ContactWithKey contact, ContactWithKey sender) {
    if (!useSign || formKey.currentState.validate()) {
      final contactName = sender.contact.fullName?.isNotEmpty == true
          ? sender.contact.fullName
          : sender.contact.viewEmail;
      var dateTime = Instant.now();

      final now =
          dateTime.inZone(DateTimeZone.local).toString('MMM dd, yyyy HH:mm z') +
              DateTimeZone.local.getUtcOffset(dateTime).toString();

      final passwordText = !isKeyBased && contact.key != null
          ? S.of(context).template_self_destructing_message_password('')
          : "";
      final lifeTimeText = lifeTime.toText(context);

      final viewBody = S.of(context).template_self_destructing_message(
          contactName, '', passwordText, lifeTimeText, now);

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
    } else {
      scroll.jumpTo(scroll.position.maxScrollExtent);
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
