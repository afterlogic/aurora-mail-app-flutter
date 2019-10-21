import 'package:aurora_mail/database/app_database.dart';

import 'auth/state/auth_state.dart';
import 'mail/state/folders_state.dart';
import 'mail/state/mail_state.dart';

class AppStore {
  static final appDb = AppDatabase();
  static final authState = AuthState();
  static final foldersState = FoldersState();
}
