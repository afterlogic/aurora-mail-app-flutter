import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/users/users_dao.dart';
import 'package:aurora_mail/modules/auth/blocs/auth/bloc.dart';
import 'package:aurora_mail/modules/settings/models/sync_duration.dart';
import 'package:moor_flutter/moor_flutter.dart';

class SyncSettingsMethods {
  final _usersDao = new UsersDao(DBInstances.appDB);

  Future<User> setFrequency(Freq freq) async {
    final localId = AuthBloc.currentUser.localId;
    await _usersDao.updateUser(
        localId,
        new UsersCompanion(
          syncFreqInSeconds: Value(SyncFreq.freqToDuration(freq).inSeconds),
        ));

    return _usersDao.getUserByLocalId(localId);
  }
}
