import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_dao.dart';
import 'package:dm/dm.dart';

class DaoModule {
  @Provide()
  PgpKeyDao pgpKeyDao() => PgpKeyDao(DBInstances.appDB);

  @Provide()
  UsersDao userDao() => UsersDao(DBInstances.appDB);

  @Provide()
  ContactsDao contactsDao() => ContactsDao(DBInstances.appDB);

}
