import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);

  Stream<List<Message>> subscribeToMessages(Folder folder) {
    return _mailDao.watchMessages(folder.fullNameRaw);
  }
}
