import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ComposeAppBarAction {
  saveToDrafts,
  send,
  cancel,
}

class ComposeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(ComposeAppBarAction action) onAppBarActionSelected;
  final Function(Account email) onAccountChange;

  const ComposeAppBar(this.onAppBarActionSelected, this.onAccountChange);

  @override
  _ComposeAppBarState createState() => _ComposeAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _ComposeAppBarState extends State<ComposeAppBar> {
  String selectedEmail;

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () =>
            widget.onAppBarActionSelected(ComposeAppBarAction.cancel),
      ),
      title: PopupMenuButton(
        enabled: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                child: BuildProperty.multiAccountEnable
                    ? dropDownAccount(context)
                    : Text(
                        BlocProvider.of<AuthBloc>(context).currentAccount.email,
                        style: TextStyle(fontSize: 14.0),
                      )),
//            SizedBox(width: 4.0),
//            Icon(Icons.keyboard_arrow_down)
          ],
        ),
        itemBuilder: (_) => [],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () =>
              widget.onAppBarActionSelected(ComposeAppBarAction.saveToDrafts),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () =>
              widget.onAppBarActionSelected(ComposeAppBarAction.send),
        ),
      ],
    );
  }

  Widget dropDownAccount(BuildContext context) {
    final theme = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final state = authBloc.state as InitializedUserAndAccounts;

    return DropdownButton(
      underline: SizedBox.shrink(),
      iconEnabledColor: theme.appBarTheme.iconTheme.color,
      hint: Text(
        selectedEmail ??= state.account.email,
        style: TextStyle(
          fontSize: 14.0,
          color: theme.appBarTheme.iconTheme.color,
        ),
      ),
      items: state.accounts.map((value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Text(
            value.email.toString(),
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        );
      }).toList(),
      onChanged: (Account v) {
        selectedEmail = v.email;
        widget.onAccountChange(v);
        setState(() {});
      },
    );
  }
}
