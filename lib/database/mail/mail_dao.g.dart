// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_dao.dart';

// ignore_for_file: type=lint
mixin _$MailDaoMixin on DatabaseAccessor<AppDatabase> {
  $MailTable get mail => attachedDatabase.mail;
  MailDaoManager get managers => MailDaoManager(this);
}

class MailDaoManager {
  final _$MailDaoMixin _db;
  MailDaoManager(this._db);
  $$MailTableTableManager get mail =>
      $$MailTableTableManager(_db.attachedDatabase, _db.mail);
}
