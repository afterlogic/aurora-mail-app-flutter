import 'dart:math';

import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/self_destructing_bloc.dart';
import 'bloc/self_destructing_event.dart';
import 'bloc/self_destructing_state.dart';
import 'components/contact_with_key_widget.dart';

class SelectRecipient extends StatefulWidget {
  final SelfDestructingBloc bloc;

  const SelectRecipient(this.bloc);

  @override
  _SelectRecipientState createState() => _SelectRecipientState();
}

class _SelectRecipientState extends BState<SelectRecipient> {
  @override
  void initState() {
    widget.bloc.add(LoadContacts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(i18n(context, "send_self_destructing_title")),
      content: SizedBox(
        height: min(size.height / 2, 350),
        width: min(size.width - 40, 300),
        child: BlocBuilder<SelfDestructingBloc, SelfDestructingState>(
            condition: (_, state) => state is LoadedContacts,
            builder: (context, state) {
              if (state is LoadedContacts) {
                return ListView.separated(
                  itemCount: state.contacts.length,
                  separatorBuilder: (_, __) => Divider(color: Colors.grey),
                  itemBuilder: (context, i) {
                    final contact = state.contacts[i];
                    return ContactWithKeyWidget(
                      contact,
                      (contact) => Navigator.pop(context, contact),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
      actions: [
        FlatButton(
          child: Text(i18n(context, "btn_cancel")),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

