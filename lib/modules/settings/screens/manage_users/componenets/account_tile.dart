import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTile extends StatefulWidget {
  final User user;
  final bool compact;

  UserTile({@required this.user, this.compact = false})
      : super(key: Key(user.localId.toString()));

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends BState<UserTile> {
  void _selectUser() {
    if (widget.compact == true) Navigator.pop(context);
    BlocProvider.of<AuthBloc>(context).add(SelectUser(widget.user.localId));
//    RestartWidget.restartApp(context);
  }

  Future<void> _showDeleteDialog() async {
    final result = await ConfirmationDialog.show(
      context,
      i18n(context, S.settings_accounts_delete),
      i18n(context, S.settings_accounts_delete_description,
          {"account": widget.user.emailFromLogin}),
      i18n(context, S.btn_delete),
      destructibleAction: true,
    );
    if (result == true) {
      BlocProvider.of<AuthBloc>(context).add(DeleteUser(widget.user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = BlocProvider.of<AuthBloc>(context).currentUser;

    return ListTile(
      key: widget.key,
      selected: widget.compact && widget.user.localId == currentUser.localId,
      leading: _buildLeading(),
      title: Text(widget.user.emailFromLogin),
      trailing: widget.compact
          ? null
          : IconButton(
              icon: Icon(Icons.delete_outline),
              color: theme.iconTheme.color,
              tooltip: i18n(context, S.settings_accounts_delete),
              onPressed: _showDeleteDialog,
            ),
      onTap: widget.user.localId == currentUser.localId || !widget.compact
          ? null
          : _selectUser,
    );
  }

  Widget _buildLeading() {
    if (!widget.compact) {
      if (widget.user.token == null) {
        return Icon(Icons.error, color: theme.disabledColor);
      } else {
        return Icon(Icons.account_circle);
      }
    } else {
      return null;
    }
  }
}
