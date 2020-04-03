import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/contacts_repository.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/contacts_repository_impl.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:dm/dm.dart';

class DaoModule {
  @provide
  @singleton
  PgpKeyDao pgpKeyDao() => PgpKeyDao(DBInstances.appDB);

  @provide
  @singleton
  UsersDao userDao() => UsersDao(DBInstances.appDB);

  @provide
  @singleton
  ContactsDao contactsDao() => ContactsDao(DBInstances.appDB);

}
