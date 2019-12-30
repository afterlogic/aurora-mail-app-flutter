import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  final _mailApi = new MailApi();

  Stream<List<Message>> subscribeToMessages(Folder folder, bool isStarred) {
    return _mailDao.watchMessages(folder.fullNameRaw, AuthBloc.currentUser.localId, isStarred);
  }

  Future<void> deleteMessages(List<int> uids, String folderRawName) async {
    final futures = [
      _mailApi.deleteMessages(uids: uids, folderRawName: folderRawName),
      _mailDao.deleteMessages(uids, folderRawName),
    ];

    await Future.wait(futures);
  }
}
