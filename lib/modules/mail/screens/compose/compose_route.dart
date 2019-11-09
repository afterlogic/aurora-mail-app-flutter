import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';

class ComposeRoute {
  static const name = "${MessagesListRoute.name}/compose";
}

class ComposeScreenArgs {
  final Message message;
  final MailBloc bloc;

  ComposeScreenArgs(this.bloc, this.message);
}
