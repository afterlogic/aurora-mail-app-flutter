import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_group_model.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GroupsSelectDialog extends StatefulWidget {
  final List<ContactsGroup> options;

  const GroupsSelectDialog({super.key, required this.options});

  static Future<ContactsGroup?> show(
    BuildContext context,
    List<ContactsGroup> options,
  ) {
    return dialog<ContactsGroup?>(
        context: context,
        builder: (_) => GroupsSelectDialog(
              options: options,
            )).then((value) => value);
  }

  @override
  State<GroupsSelectDialog> createState() => _GroupsSelectDialogState();
}

class _GroupsSelectDialogState extends State<GroupsSelectDialog> {
  ContactsGroup? selectedGroup;
  @override
  void initState() {
    super.initState();
  }

  void onTap(ContactsGroup g) {
    selectedGroup = g == selectedGroup ? null : g;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;

    return AlertDialog(
      title: Text(S.of(context).contacts_group_add_to_group),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.options.length,
          (i) => InkWell(
            onTap: () => onTap(widget.options[i]),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 16, bottom: 6, left: 8, top: 6),
                    child: Row(
                      children: [
                        Icon(MdiIcons.pound, color: widget.options[i] == selectedGroup
                        ? selectedColor
                          : null,),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.options[i].name,
                          style: TextStyle(
                              fontSize: 18,
                              color: widget.options[i] == selectedGroup
                                  ? selectedColor
                                  : null),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(
            context,
            null,
          ),
        ),
        TextButton(
          child: Text(S.of(context).add, style: selectedGroup == null
              ? TextStyle(color: Theme.of(context).disabledColor): null,),
          onPressed: selectedGroup == null
              ? null
              : () => Navigator.pop(
                    context,
                    selectedGroup,
                  ),
        )
      ],
    );
  }
}
