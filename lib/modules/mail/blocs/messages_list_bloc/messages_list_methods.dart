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

  Stream<List<Message>> getMessages(
    Folder folder,
    bool isStarred,
    bool unreadOnly,
    List<SearchParams> params,
    User user,
    Account account,
    int page,
  ) {
    return _mailDao.getMessages(
      folder.fullNameRaw,
      user.localId,
      params,
      account.entityId,
      isStarred,
      unreadOnly,
      _limit,
      page * _limit,
    );
  }

  Future<void> deleteMessages(List<Message> messages) async {
    final foldersForPermanentlyDelete = await _folderDao.getByType(
      [
        Folder.getNumberFromFolderType(FolderType.trash),
        Folder.getNumberFromFolderType(FolderType.spam)
      ],
      account.localId,
    );
    final trashFolderName = foldersForPermanentlyDelete
        .firstWhere(
          (item) =>
              item.type == Folder.getNumberFromFolderType(FolderType.trash),
        )
        .fullNameRaw;

    final foldersForPermanentlyDeleteName =
        foldersForPermanentlyDelete.map((item) => item.fullNameRaw).toList();

    final splitToFolder = <String, List<int>>{};

    for (var message in messages) {
      final uids = splitToFolder[message.folder] ?? [];
      uids.add(message.uid);
      splitToFolder[message.folder] = uids;
    }
    for (var folder in splitToFolder.keys) {
      final uids = splitToFolder[folder];
     await _mailDao.deleteMessages(uids, folder);
      if (foldersForPermanentlyDeleteName.contains(folder)) {
        await _mailApi.deleteMessages(
          uids: uids,
          folderRawName: folder,
        );
      } else {
        await _mailApi.moveToTrash(
          uids: uids,
          folderRawName: folder,
          trashRawName: trashFolderName,
        );
      }
    }
  }

  Future moveMessages(List<Message> messages, FolderType toFolder) async {
    final splitToFolder = <String, List<int>>{};
    final toFolderName = (await _folderDao.getByType(
      [Folder.getNumberFromFolderType(toFolder)],
      account.localId,
    ))
        .first
        .fullNameRaw;

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

      futures.add(_mailApi.moveMessage(
        uids: uids,
        fromFolder: folder,
        toFolder: toFolderName,
      ));

      await Future.wait(futures);
    }
  }

  static const _limit = 30;

  Future emptyFolder(String folder) async {
    await _mailApi.clearFolder(folder);
    await _mailDao.clearFolder(folder);
  }

  Future moveToFolder(List<Message> messages, Folder folder) async {
    final splitToFolder = <String, List<int>>{};
    for (var message in messages) {
      final uids = splitToFolder[message.folder] ?? [];
      uids.add(message.uid);
      splitToFolder[message.folder] = uids;
    }
    for (var value in splitToFolder.entries) {
      await _mailApi.moveMessage(
        uids: value.value,
        fromFolder: value.key,
        toFolder: folder.fullNameRaw,
      );
    }
  }
}
