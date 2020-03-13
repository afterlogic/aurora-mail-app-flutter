import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:flutter/foundation.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  MailApi _mailApi;

  MessagesListMethods({@required User user, @required Account account}) {
    _mailApi = new MailApi(user: user, account: account);
  }

  Future<Stream<List<Message>>> getMessages(
    Folder folder,
    bool isStarred,
    bool unreadOnly,
    String searchTerm,
    SearchPattern searchPattern,
    User user,
    Account account,
  ) {
    return _mailDao.getMessages(
      folder.fullNameRaw,
      user.localId,
      searchTerm,
      searchPattern,
      account.entityId,
      isStarred,
      unreadOnly,
    );
  }

  Future<void> deleteMessages(List<int> uids, String folderRawName) async {
    final futures = [
      _mailApi.deleteMessages(uids: uids, folderRawName: folderRawName),
      _mailDao.deleteMessages(uids, folderRawName),
    ];

    await Future.wait(futures);
  }

  static const _limit = 100;
}
