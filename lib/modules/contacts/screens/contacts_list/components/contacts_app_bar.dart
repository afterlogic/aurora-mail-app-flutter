//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/screens/contacts_list/components/select_app_bar.dart';
import 'package:aurora_mail/modules/contacts/screens/group_view/group_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/search_bar.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/user_selection_popup.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/utils/storage_util.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isAppBar;
  final bool enable;
  final SelectionController<String, Contact> controller;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  const ContactsAppBar({
    this.isAppBar = true,
    this.enable = true,
    this.controller
  });

  @override
  _ContactsAppBarState createState() => _ContactsAppBarState();
}

class _ContactsAppBarState extends State<ContactsAppBar> {
  ContactAppBarMode _mode = ContactAppBarMode.common;
  final _searchCtrl = TextEditingController();
  ContactsBloc _contactsBloc;

  @override
  void initState() {
    super.initState();
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);
    widget.controller.addListener(update);
    if (_contactsBloc.searchPattern != null) {
      _mode = ContactAppBarMode.search;
      _searchCtrl.text = _contactsBloc.searchPattern;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(update);
  }

  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: widget.controller.enable ? SelectAppBar(widget.controller, _contactsBloc) :  _mode == ContactAppBarMode.search && widget.enable
          ? SearchBar(
              _searchCtrl,
              changeMode,
              search,
              isAppBar: widget.isAppBar,
            )
          : common(context),
    );
  }

  void search(String text) {
    _contactsBloc.add(SearchContacts(text));
  }

  void changeMode() {
    _searchCtrl.clear();
    if (_mode == ContactAppBarMode.common) {
      _mode = ContactAppBarMode.search;
    } else {
      _mode = ContactAppBarMode.common;
    }
    setState(() {});
  }

  Widget common(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildTitle(BuildContext context, ContactsState state) {
      if (state.selectedStorage != null && state.storages.isNotEmpty) {
        final selectedStorage =
            state.storages.firstWhere((s) => s.id == state.selectedStorage);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).contacts),
            SizedBox(height: 3.0),
            Text(
              selectedStorage.displayName.length > 6 && selectedStorage.displayName.substring(0, 6) == 'LABEL_'
                  ? getStorageName(selectedStorage.displayName.substring(6), context)
                  : selectedStorage.displayName,
              style: TextStyle(
                  fontSize: theme.textTheme.caption.fontSize,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      } else if (state.selectedGroup != null && state.groups.isNotEmpty) {
        final selectedGroup =
            state.groups.firstWhere((g) => g.uuid == state.selectedGroup);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).contacts),
            SizedBox(height: 3.0),
            Text(
              "# " + selectedGroup.name,
              style: TextStyle(
                  fontSize: theme.textTheme.caption.fontSize,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      } else if (state.showAllVisibleContacts == true) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).contacts),
            const SizedBox(height: 3.0),
            Text(
              S.of(context).contacts_list_app_bar_all_contacts,
              style: TextStyle(
                  fontSize: theme.textTheme.caption.fontSize,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      } else {
        return Text(S.of(context).contacts);
      }
    }

    return BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
      if (!widget.isAppBar) {
        return Row(
          children: <Widget>[
            if (state.selectedGroup != null)
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  final group = state.groups
                      .firstWhere((g) => g.uuid == state.selectedGroup);
                  Navigator.pushNamed(context, GroupViewRoute.name,
                      arguments: GroupViewScreenArgs(group, _contactsBloc));
                },
              ),
            Expanded(
              child: InkWell(
                onTap: changeMode,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, top: 6),
                    child: Icon(
                      Icons.search,
                      color: theme.disabledColor,
                    ),
                  ),
                ),
              ),
            ),
            if (BuildProperty.multiUserEnable)
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (_, state) =>
                    UserSelectionPopup((state as SettingsLoaded).users),
              ),
          ],
        );
      }

      return AMAppBar(
        title: _buildTitle(context, state),
        actions: widget.enable
            ? <Widget>[
                if (state.selectedGroup != null)
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      final group = state.groups
                          .firstWhere((g) => g.uuid == state.selectedGroup);
                      Navigator.pushNamed(context, GroupViewRoute.name,
                          arguments: GroupViewScreenArgs(group, _contactsBloc));
                    },
                  ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: changeMode,
                ),
                if (BuildProperty.multiUserEnable)
                  BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (_, state) =>
                        UserSelectionPopup((state as SettingsLoaded).users),
                  ),
              ]
            : null,
      );
    });
  }
}

enum ContactAppBarMode { common, search }
