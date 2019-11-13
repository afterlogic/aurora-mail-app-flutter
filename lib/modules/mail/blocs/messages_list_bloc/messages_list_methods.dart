import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  final _mailApi = new MailApi();

  Stream<List<Message>> subscribeToMessages(Folder folder) {
    return _mailDao.watchMessages(folder.fullNameRaw);
  }

  Future<void> deleteMessages(List<int> uids, Folder folder) async {
    final futures = [
      _mailApi.deleteMessages(uids: uids, folder: folder),
      _mailDao.deleteMessages(uids, folder),
    ];

    await Future.wait(futures);
  }
}
