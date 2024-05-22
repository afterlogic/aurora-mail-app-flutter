import 'dart:math';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_creation.dart';
import 'package:aurora_mail/shared_ui/colored_checkbox.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';

const _horizontalHeaderPadding = 24.0;
const _horizontalSectionPadding = 22.0;

class CalendarDrawer extends StatefulWidget {
  @override
  _CalendarDrawerState createState() => _CalendarDrawerState();
}

class _CalendarDrawerState extends BState<CalendarDrawer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        selectedColor: theme.primaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                        horizontal: _horizontalHeaderPadding)
                    .copyWith(top: 16, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My calendars',
                        style: TextStyle(color: theme.disabledColor)),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          CalendarCreationDialog.show(context);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
              ),
              const Divider(
                color: const Color(0xFFF1F1F1),
                height: 1,
              ),
              CollapsibleCheckboxList(
                title: 'MyCalendar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollapsibleCheckboxList extends StatefulWidget {
  final String title;

  CollapsibleCheckboxList({
    required this.title,
  });

  @override
  _CollapsibleCheckboxListState createState() =>
      _CollapsibleCheckboxListState();
}

class _CollapsibleCheckboxListState extends State<CollapsibleCheckboxList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool? _isChecked = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  final _menuItems = [
    _MenuItem(icon: Icon(Icons.edit_outlined), titleBuilder: (ctx) => S.of(ctx).contacts_view_app_bar_edit_contact, onTap: (){}),
    _MenuItem(icon: Icon(Icons.file_download_outlined), titleBuilder: (ctx) => 'Import ICS file', onTap: (){}),
    _MenuItem(icon: Icon(Icons.link), titleBuilder: (ctx) => 'Get a link', onTap: (){}),
    _MenuItem(icon: Icon(Icons.group_add_outlined), titleBuilder: (ctx) => S.of(ctx).btn_share, onTap: (){}),
    _MenuItem(icon: Icon(Icons.delete_outline), titleBuilder: (ctx) => S.of(ctx).btn_delete, onTap: (){}),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Padding(
            padding: const EdgeInsets.only(
                    left: _horizontalSectionPadding,
                    right: _horizontalHeaderPadding)
                .copyWith(
              top: 12,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: ColoredCheckbox(
                    color: Colors.red,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(widget.title),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value *
                          pi, // 180 degrees in radians
                      child: Icon(Icons.keyboard_arrow_down, size: 32, color: Color(0xFFB6B5B5),),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animationController,
          child: Column(children:
            _menuItems.map((e) => ListTile(
              title: Text(e.titleBuilder(context)),
              tileColor: _isExpanded ? Color(0xFFF7FBFF) : null,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _horizontalSectionPadding, vertical: 0),
              dense: true,
              horizontalTitleGap: 0,
              leading: e.icon,
              iconColor: Theme.of(context).primaryColor,
              onTap: e.onTap,
            )).toList()

          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final Icon icon;
  final String Function(BuildContext ctx) titleBuilder;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.titleBuilder,
    required this.onTap,
  });
}