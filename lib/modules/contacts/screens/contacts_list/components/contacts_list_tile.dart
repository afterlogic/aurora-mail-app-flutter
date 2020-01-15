import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsListTile extends StatelessWidget {
  final Contact contact;
  final void Function(Contact) onPressed;
  final void Function(Contact) onDeleteContact;

  ContactsListTile({@required this.contact, @required this.onPressed, @required this.onDeleteContact})
      : super(key: Key(contact.uuid));

  Widget _getStorageIcon(BuildContext context) {
    final bloc = BlocProvider.of<ContactsBloc>(context);
    if (bloc.state.showAllVisibleContacts) {
      switch (contact.storage) {
        case StorageNames.personal:
          return Icon(WebMailIcons.personal);
        case StorageNames.shared:
          return Icon(WebMailIcons.shared_with_all);
        case StorageNames.team:
          return Icon(Icons.business_center);
        default:
          return Icon(MdiIcons.folderAccountOutline);
      }
    } else {
      return SizedBox();
    }
  }

  bool get allowDeleting {
    return contact.storage == StorageNames.personal ||
        contact.storage == StorageNames.shared;
  }

  @override
  Widget build(BuildContext context) {
    if (allowDeleting) {
    return Dismissible(
      key: Key(contact.uuid),
      direction: DismissDirection.endToStart,
      child: _buildTile(context),
      onDismissed: (_) => onDeleteContact(contact),
      confirmDismiss: (_) => ConfirmationDialog.show(
          context,
          i18n(context, "contacts_delete_title"),
          i18n(context, "contacts_delete_desc_with_name", {"contact": contact.fullName}),
          i18n(context, "btn_delete")),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 16.0,
              top: 0.0,
              bottom: 0.0,
              child: Icon(Icons.delete_outline, color: Colors.white, size: 36.0),
            ),
          ],
        ),
      ),
    );
    } else {
      return _buildTile(context);
    }
  }

  Widget _buildTile(BuildContext context) {
    final theme = Theme.of(context);
    final name = contact.fullName;

    return ListTile(
      title: Text(name != null && name.isNotEmpty ? name : contact.viewEmail),
      subtitle: name != null && name.isNotEmpty
          ? Text(contact.viewEmail)
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (contact.viewEmail == AuthBloc.currentAccount.email)
            Container(
              decoration: BoxDecoration(
                color: theme.disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              margin: EdgeInsets.only(right: 4.0),
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
              child: Text(
                i18n(context, "contacts_list_its_me_flag"),
                style: theme.textTheme.caption,
              ),
            ),
          _getStorageIcon(context),
        ],
      ),
      onTap: () => onPressed(contact),
    );
  }
}