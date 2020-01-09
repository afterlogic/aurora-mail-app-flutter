import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_types.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:flutter/cupertino.dart';

class ComposeRoute {
  static const name = "compose_message";
}

class ComposeScreenArgs {
  final Message message;
  final MailBloc mailBloc;
  final ContactsBloc contactsBloc;
  final int draftUid;
  final ComposeType composeType;

  ComposeScreenArgs({
    @required this.mailBloc,
    @required this.contactsBloc,
    this.message,
    this.draftUid,
    @required this.composeType,
  }) {
    if (composeType == ComposeType.fromDrafts &&
        (draftUid == null || message == null)) {
      throw "A message opened from drafts must have messageBody and draftUid";
    }
    if ((composeType == ComposeType.forward ||
            composeType == ComposeType.reply ||
            composeType == ComposeType.replyAll) &&
        message == null) {
      throw "Forward, reply and replyAll must be supplied a message";
    }
  }
}
