import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/pgp/pgp_key_dao.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:inject/inject.dart';

@module
class DaoModule {
  @provide
  @singleton
  PgpKeyDao pgpKeyDao() => PgpKeyDao(DBInstances.appDB);

  @provide
  @singleton
  UsersDao userDao() => UsersDao(DBInstances.appDB);
}
