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

  final dividerColor = const Color(0xFFD0D0D0);

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
                    Divider(
                      color: dividerColor,
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
                    if (sharedCalendars?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalHeaderPadding)
                            .copyWith(top: 16, bottom: 4),
                        child: Text('Shared with me',
                            style: TextStyle(color: theme.disabledColor)),
                      ),
                    if (sharedCalendars != null)
                      Divider(
                        color: dividerColor,
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
                    if (sharedToAllCalendars?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: _horizontalHeaderPadding)
                            .copyWith(top: 16, bottom: 4),
                        child: Text('Shared with all',
                            style: TextStyle(color: theme.disabledColor)),
                      ),
                    if (sharedToAllCalendars != null)
                      Divider(
                        color: dividerColor,
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
                    const SizedBox(height: 24,),
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
  List<_MenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _menuItems = _buildMenuItems();
  }

  @override
  void didUpdateWidget(newWidget) {
    super.didUpdateWidget(widget);
    if (widget.calendar != newWidget.calendar) {
      _menuItems = _buildMenuItems();
      setState(() {});
    }
  }

  List<_MenuItem> _buildSharedToAllAccessReadMenuItems() {
    return [
      _MenuItem(
        icon: Icon(Icons.link),
        titleBuilder: (ctx) => 'Get a link',
        onTap: (ctx) {},
      )
    ];
  }

  List<_MenuItem> _buildSharedToAllAccessWriteMenuItems() {
    return [
      _MenuItem(
        icon: Icon(Icons.edit_outlined),
        titleBuilder: (ctx) => S.of(context).contacts_view_app_bar_edit_contact,
        onTap: (ctx) {
          CalendarEditDialog.show(ctx, calendar: widget.calendar).then((value) {
            if (value != null) {
              BlocProvider.of<CalendarsBloc>(context)
                  .add(UpdateCalendar(value));
            }
          });
        },
      ),
      _MenuItem(
        icon: Icon(Icons.file_download_outlined),
        titleBuilder: (ctx) => 'Import ICS file',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.link),
        titleBuilder: (ctx) => 'Get a link',
        onTap: (ctx) {},
      ),
    ];
  }

  List<_MenuItem> _buildSharedAccessReadMenuItems() {
    return [
      _MenuItem(
        icon: Icon(Icons.link),
        titleBuilder: (ctx) => 'Get a link',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.unsubscribe_outlined),
        titleBuilder: (ctx) => 'Unsubscribe from calendar',
        onTap: (ctx) {},
      ),
    ];
  }

  List<_MenuItem> _buildSharedAccessWriteMenuItems() {
    return [
      _MenuItem(
        icon: Icon(Icons.edit_outlined),
        titleBuilder: (ctx) => S.of(context).contacts_view_app_bar_edit_contact,
        onTap: (ctx) {
          CalendarEditDialog.show(ctx, calendar: widget.calendar).then((value) {
            if (value != null) {
              BlocProvider.of<CalendarsBloc>(context)
                  .add(UpdateCalendar(value));
            }
          });
        },
      ),
      _MenuItem(
        icon: Icon(Icons.file_download_outlined),
        titleBuilder: (ctx) => 'Import ICS file',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.link),
        titleBuilder: (ctx) => 'Get a link',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.group_add_outlined),
        titleBuilder: (ctx) => S.of(context).btn_share,
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.unsubscribe_outlined),
        titleBuilder: (ctx) => 'Unsubscribe from calendar',
        onTap: (ctx) {},
      ),
    ];
  }

  List<_MenuItem> _buildDefaultMenuItems() {
    return [
      _MenuItem(
        icon: Icon(Icons.edit_outlined),
        titleBuilder: (ctx) => S.of(context).contacts_view_app_bar_edit_contact,
        onTap: (ctx) {
          CalendarEditDialog.show(ctx, calendar: widget.calendar).then((value) {
            if (value != null) {
              BlocProvider.of<CalendarsBloc>(context)
                  .add(UpdateCalendar(value));
            }
          });
        },
      ),
      _MenuItem(
        icon: Icon(Icons.file_download_outlined),
        titleBuilder: (ctx) => 'Import ICS file',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.link),
        titleBuilder: (ctx) => 'Get a link',
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.group_add_outlined),
        titleBuilder: (ctx) => S.of(context).btn_share,
        onTap: (ctx) {},
      ),
      _MenuItem(
        icon: Icon(Icons.delete_outline),
        titleBuilder: (ctx) => S.of(context).btn_delete,
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
        },
      ),
    ];
  }

  List<_MenuItem> _buildMenuItems() {
    if (widget.calendar.sharedToAll) {
      if (widget.calendar.sharedToAllAccess == 2) {
        return _buildSharedToAllAccessReadMenuItems();
      } else if (widget.calendar.sharedToAllAccess == 1) {
        return _buildSharedToAllAccessWriteMenuItems();
      } else {
        return [];
      }
    } else if (widget.calendar.shared) {
      if (widget.calendar.access == 2) {
        return _buildSharedAccessReadMenuItems();
      } else if (widget.calendar.access == 1) {
        return _buildSharedAccessWriteMenuItems();
      } else {
        return [];
      }
    } else {
      return _buildDefaultMenuItems();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _animationController.forward().then((value) => setState(() {}));
    } else {
      setState(() {});
      _animationController.reverse();
    }
  }

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
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: ColoredCheckbox(
                      color: widget.calendar.color,
                      value: widget.isChecked,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      if (widget.calendar.name.isNotEmpty)
                        Text(
                          '${widget.calendar.name} - ${widget.calendar.owner}',
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        )
                      else
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
                const SizedBox(
                  width: 2,
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
                  .map((e) => Container(
                color: _isExpanded ? Color(0xFFECF5FF) : null,
                    child: ListTile(
                          title: Text(e.titleBuilder(context)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: _horizontalSectionPadding, vertical: 0),
                          dense: true,
                          horizontalTitleGap: 0,
                          leading: e.icon,
                          iconColor: Theme.of(context).primaryColor,
                          onTap: () => e.onTap(context),
                        ),
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
