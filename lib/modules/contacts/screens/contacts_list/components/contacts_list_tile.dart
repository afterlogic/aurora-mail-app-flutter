//@dart=2.9
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/res/icons/webmail_icons.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsListTile extends StatefulWidget {
  final Contact contact;
  final void Function(Contact) onPressed;
  final void Function(Contact) onDeleteContact;
  final SelectionController selectionController;


  ContactsListTile(
      {@required this.contact,
      @required this.onPressed,
      @required this.onDeleteContact,
      this.selectionController,
      })
      : super(key: Key(contact.uuid));

  @override
  State<ContactsListTile> createState() => _ContactsListTileState();
}

class _ContactsListTileState extends State<ContactsListTile> {

  void initState() {
    super.initState();
    widget.selectionController.addListener(onSelect);
  }

  @override
  void dispose() {
    super.dispose();
    widget.selectionController.removeListener(onSelect);
  }

  onSelect() {
      setState(() {});
  }

  Widget _getStorageIcon(BuildContext context) {
    switch (widget.contact.storage) {
      case StorageNames.personal:
        return Icon(WebMailIcons.personal);
      case StorageNames.shared:
        return Icon(WebMailIcons.shared_with_all);
      case StorageNames.team:
        return Icon(Icons.business_center);
      default:
        return Icon(WebMailIcons.personal);
    }
  }

  bool get allowDeleting {
    return widget.contact.storage == StorageNames.personal ||
        widget.contact.storage == StorageNames.shared;
  }

  Widget _buildTile(BuildContext context) {
    final theme = Theme.of(context);
    final selected = widget.selectionController.isSelected(widget.contact.uuid);
    final title = widget.contact.fullName;
    final subTitle = widget.contact.viewEmail;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final contactsBloc = BlocProvider.of<ContactsBloc>(context);
    final currentStorage = contactsBloc.state.storages.firstWhere(
            (s) => s.id == contactsBloc.state.selectedStorage,
        orElse: () => null);

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? theme.primaryColor.withOpacity(0.2)
                  : theme.primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                title?.isNotEmpty == true ? title[0].toUpperCase() : "C",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        title?.isNotEmpty == true
            ? title
            : S.of(context).label_contact_with_not_name,
        maxLines: 1,
        style: title?.isNotEmpty == true
            ? null
            : TextStyle(color: theme.disabledColor),
      ),
      subtitle: Text(
        subTitle?.isNotEmpty == true
            ? subTitle
            : S.of(context).contacts_email_empty,
        style: TextStyle(
          color: subTitle?.isNotEmpty == true
              ? theme.disabledColor
              : theme.disabledColor.withAlpha(theme.disabledColor.alpha ~/ 2),
        ),
        maxLines: 1,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (widget.contact.pgpPublicKey != null && widget.contact.pgpPublicKey.isNotEmpty) Icon(MdiIcons.key),
          if (currentStorage != null &&
              currentStorage.name == StorageNames.team &&
              widget.contact.viewEmail == authBloc.currentAccount.email)
            Container(
              decoration: BoxDecoration(
                color: theme.disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              margin: EdgeInsets.only(right: 4.0),
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
              child: Text(
                S.of(context).contacts_list_its_me_flag,
                style: theme.textTheme.caption,
              ),
            ),
          _getStorageIcon(context),
          if (widget.selectionController.enable)
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selected
                        ? null
                        : Border.all(
                        color: theme.primaryColor, width: 2),
                    color: selected ? theme.primaryColor : null,
                  ),
                  child: SizedBox(
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectionController.isSelected(widget.contact.uuid);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).brightness == Brightness.light
            ? const Color.fromRGBO(0, 0, 0, 0.05)
            : const Color.fromRGBO(255, 255, 255, 0.05)
            : null,
      ),
      child: InkWell(
        onLongPress: changeEnable,
        onTap: widget.selectionController.enable ? changeEnable : () => widget.onPressed(widget.contact),
        child: allowDeleting && !widget.selectionController.enable ? Dismissible(
          key: Key(widget.contact.uuid),
          direction: DismissDirection.endToStart,
          child: _buildTile(context),
          onDismissed: (_) => widget.onDeleteContact(widget.contact),
          confirmDismiss: (_) => ConfirmationDialog.show(
            context,
            S.of(context).contacts_delete_title,
            S.of(context).contacts_delete_desc_with_name(widget.contact.fullName),
            S.of(context).btn_delete,
            destructibleAction: true,
          ),
          background: Container(
            color: Theme.of(context).errorColor,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 16.0,
                  top: 0.0,
                  bottom: 0.0,
                  child:
                  Icon(Icons.delete_outline, color: Colors.white, size: 36.0),
                ),
              ],
            ),
          ),
        ) : _buildTile(context),
      ),
    );
  }

  changeEnable() {
    widget.selectionController.addOrRemove(widget.contact.uuid, widget.contact);
  }
}
