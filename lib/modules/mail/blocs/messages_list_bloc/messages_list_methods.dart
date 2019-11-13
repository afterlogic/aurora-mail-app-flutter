import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  final _foldersDao = new FoldersDao(DBInstances.appDB);
  final _mailApi = new MailApi();

  Stream<List<Message>> subscribeToMessages(Folder folder) {
    return _mailDao.watchMessages(folder.fullNameRaw);
  }

  Future<void> deleteMessages(List<Message> messages) async {
    if (messages.isEmpty) return null;
    final uids = messages.map((m) => m.uid).toList();
    final folder = await _foldersDao.getFolderByRawName(messages[0].folder);
    final futures = [
      _mailApi.deleteMessages(uids: uids, folder: folder),
      _mailDao.deleteMessages(uids, folder),
    ];

    await Future.wait(futures);
  }
}
