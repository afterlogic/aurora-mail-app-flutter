import 'package:aurora_mail/models/folder.dart';

class MailRoute {
  static const name = "mail";
}

class MailScreenArguments {
  final Folder folder;

  MailScreenArguments(this.folder);
}