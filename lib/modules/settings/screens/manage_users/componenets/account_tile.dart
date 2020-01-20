import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTile extends StatefulWidget {
  final User user;

  AccountTile({@required this.user}) : super(key: Key(user.localId.toString()));

  @override
  _AccountTileState createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  void _selectUser() {
    BlocProvider.of<AuthBloc>(context).add(SelectUser(widget.user.localId));
  }

  Future<void> _showDeleteDialog() async {
    final result = await ConfirmationDialog.show(
      context,
      i18n(context, "settings_accounts_delete"),
      i18n(context, "settings_accounts_delete_description", {"account": widget.user.emailFromLogin}),
      i18n(context, "btn_delete"),
      destructibleAction: true,
    );
    if (result == true) {
      BlocProvider.of<AuthBloc>(context).add(DeleteUser(widget.user.localId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = BlocProvider.of<AuthBloc>(context).currentUser;

    return ListTile(
      key: widget.key,
      selected: widget.user.localId == currentUser.localId,
      leading: widget.user.token == null
          ? Icon(Icons.error, color: Theme.of(context).disabledColor)
          : Icon(Icons.account_circle),
      title: Text(widget.user.emailFromLogin),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline),
        color: Theme.of(context).iconTheme.color,
        tooltip: i18n(context, "settings_accounts_delete"),
        onPressed: _showDeleteDialog,
      ),
      onTap: widget.user.localId == currentUser.localId ? null : _selectUser,
    );
  }
}
