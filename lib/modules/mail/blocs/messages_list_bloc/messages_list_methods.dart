import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/folders/folders_dao.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:flutter/foundation.dart';

class MessagesListMethods {
  final _mailDao = MailDao(DBInstances.appDB);
  final _folderDao = FoldersDao(DBInstances.appDB);
  final Account account;
  MailApi _mailApi;

  MessagesListMethods({@required User user, @required this.account}) {
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

  Future<void> deleteMessages(List<Message> messages) async {
    final trashRawName = (await _folderDao.getByType(
      Folder.getNumberFromFolderType(FolderType.trash),
      account.localId,
    ))
        .first
        .fullNameRaw;
    final splitToFolder = <String, List<int>>{};

    for (var message in messages) {
      final uids = splitToFolder[message.folder] ?? [];
      uids.add(message.uid);
      splitToFolder[message.folder] = uids;
    }
    for (var folder in splitToFolder.keys) {
      final uids = splitToFolder[folder];
      final futures = [
        _mailDao.deleteMessages(uids, folder),
      ];
      if (folder == trashRawName) {
        futures.add(_mailApi.deleteMessages(
          uids: uids,
          folderRawName: folder,
        ));
      } else {
        futures.add(_mailApi.moveToTrash(
          uids: uids,
          folderRawName: folder,
          trashRawName: trashRawName,
        ));
      }
      await Future.wait(futures);
    }
  }

  static const _limit = 100;
}
