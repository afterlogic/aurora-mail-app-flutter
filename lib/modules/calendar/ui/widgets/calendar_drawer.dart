import 'dart:math';

import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_creation.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_edit.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/deletion_confirm_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/shared_ui/colored_checkbox.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocBuilder<CalendarsBloc, CalendarsState>(
            builder: (context, state) {
              final myCalendars = state.calendars
                  ?.where((c) => !c.sharedToAll && !c.shared)
                  .toList();
              final sharedCalendars = state.calendars
                  ?.where((c) => c.shared && !c.sharedToAll)
                  .toList();
              final sharedToAllCalendars =
                  state.calendars?.where((c) => c.sharedToAll).toList();
              return SingleChildScrollView(
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
                                CalendarCreationDialog.show(context)
                                    .then((value) {
                                  if (value != null) {
                                    BlocProvider.of<CalendarsBloc>(context).add(
                                        CreateCalendar(creationData: value));
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ))
                        ],
                      ),
                    ),
                    const Divider(
                      color: const Color(0xFFDDDDDD),
                      height: 1,
                    ),
                    (myCalendars != null)
                        ? Column(
                            children: myCalendars
                                .map<Widget>((e) => CollapsibleCheckboxList(
                                      calendar: e,
                                      onChanged: (bool? value) {
                                        BlocProvider.of<CalendarsBloc>(context)
                                            .add(UpdateCalendarSelection(
                                                calendarId: e.id,
                                                selected: value ?? false));
                                      },
                                      isChecked: e.selected,
                                    ))
                                .toList(),
                          )
                        : SizedBox.shrink(),
                    if (sharedCalendars != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalHeaderPadding)
                            .copyWith(top: 16, bottom: 4),
                        child: Text('Shared with me',
                            style: TextStyle(color: theme.disabledColor)),
                      ),
                    if (sharedCalendars != null)
                      const Divider(
                        color: const Color(0xFF000000),
                        height: 1,
                      ),
                    (sharedCalendars != null)
                        ? Column(
                            children: sharedCalendars
                                .map<Widget>((e) => CollapsibleCheckboxList(
                                      calendar: e,
                                      onChanged: (bool? value) {
                                        BlocProvider.of<CalendarsBloc>(context)
                                            .add(UpdateCalendarSelection(
                                                calendarId: e.id,
                                                selected: value ?? false));
                                      },
                                      isChecked: e.selected,
                                    ))
                                .toList(),
                          )
                        : SizedBox.shrink(),
                    if (sharedToAllCalendars != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalHeaderPadding)
                            .copyWith(top: 16, bottom: 4),
                        child: Text('Shared with all',
                            style: TextStyle(color: theme.disabledColor)),
                      ),
                    if (sharedToAllCalendars != null)
                      const Divider(
                        color: const Color(0xFFDDDDDD),
                        height: 1,
                      ),
                    (sharedToAllCalendars != null)
                        ? Column(
                            children: sharedToAllCalendars
                                .map<Widget>((e) => CollapsibleCheckboxList(
                                      calendar: e,
                                      onChanged: (bool? value) {
                                        BlocProvider.of<CalendarsBloc>(context)
                                            .add(UpdateCalendarSelection(
                                                calendarId: e.id,
                                                selected: value ?? false));
                                      },
                                      isChecked: e.selected,
                                    ))
                                .toList(),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CollapsibleCheckboxList extends StatefulWidget {
  final ViewCalendar calendar;
  final bool isChecked;
  final Function(bool?) onChanged;

  CollapsibleCheckboxList(
      {required this.calendar,
      required this.onChanged,
      required this.isChecked});

  @override
  _CollapsibleCheckboxListState createState() =>
      _CollapsibleCheckboxListState();
}

class _CollapsibleCheckboxListState extends State<CollapsibleCheckboxList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _menuItems = [
      _MenuItem(
          icon: Icon(Icons.edit_outlined),
          titleBuilder: (ctx) => S.of(ctx).contacts_view_app_bar_edit_contact,
          onTap: (ctx) {
            CalendarEditDialog.show(ctx, calendar: widget.calendar)
                .then((value) {
              if (value != null) {
                BlocProvider.of<CalendarsBloc>(context)
                    .add(UpdateCalendar(value));
              }
            });
          }),
      _MenuItem(
          icon: Icon(Icons.file_download_outlined),
          titleBuilder: (ctx) => 'Import ICS file',
          onTap: (ctx) {}),
      _MenuItem(
          icon: Icon(Icons.link),
          titleBuilder: (ctx) => 'Get a link',
          onTap: (ctx) {}),
      _MenuItem(
          icon: Icon(Icons.group_add_outlined),
          titleBuilder: (ctx) => S.of(ctx).btn_share,
          onTap: (ctx) {}),
      _MenuItem(
          icon: Icon(Icons.delete_outline),
          titleBuilder: (ctx) => S.of(ctx).btn_delete,
          onTap: (ctx) {
            CalendarConfirmDialog.show(context,
                    title: 'Delete calendar',
                    confirmMessage:
                        "Are you sure you want to delete calendar ${widget.calendar.name}?")
                .then((value) {
              if (value != true) return;
              BlocProvider.of<CalendarsBloc>(ctx)
                  .add(DeleteCalendar(widget.calendar));
              Navigator.of(context).pop();
            });
          }),
    ];
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

  late final List<_MenuItem> _menuItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Padding(
            padding: const EdgeInsets.only(
                    left: _horizontalSectionPadding,
                    right: _horizontalHeaderPadding - 3)
                .copyWith(
              top: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: ColoredCheckbox(
                    color: widget.calendar.color,
                    value: widget.isChecked,
                    onChanged: widget.onChanged,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.calendar.name),
                      if ((widget.calendar.shared &&
                              widget.calendar.access == 2 &&
                              !widget.calendar.sharedToAll) ||
                          (widget.calendar.sharedToAll &&
                              widget.calendar.sharedToAllAccess == 2))
                        Text(
                          'read',
                          style:
                              TextStyle(color: Color(0xFFB6B5B5), fontSize: 14),
                        ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value *
                          pi, // 180 degrees in radians
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 32,
                        color: Color(0xFFB6B5B5),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animationController,
          child: Column(
              children: _menuItems
                  .map((e) => ListTile(
                        title: Text(e.titleBuilder(context)),
                        tileColor: _isExpanded ? Color(0xFFF7FBFF) : null,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _horizontalSectionPadding, vertical: 0),
                        dense: true,
                        horizontalTitleGap: 0,
                        leading: e.icon,
                        iconColor: Theme.of(context).primaryColor,
                        onTap: () => e.onTap(context),
                      ))
                  .toList()),
        ),
      ],
    );
  }
}

class _MenuItem {
  final Icon icon;
  final String Function(BuildContext ctx) titleBuilder;
  final void Function(BuildContext ctx) onTap;

  const _MenuItem({
    required this.icon,
    required this.titleBuilder,
    required this.onTap,
  });
}
