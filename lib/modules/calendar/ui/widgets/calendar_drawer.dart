import 'dart:math';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_creation.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_edit.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_links_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_sharing_dialog.dart';
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
    final User? user = BlocProvider.of<AuthBloc>(context).currentUser;
    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        selectedColor: theme.primaryColor,
        child: SafeArea(
          child: BlocBuilder<CalendarsBloc, CalendarsState>(
            builder: (context, state) {
              final myCalendars = state.calendars
                  ?.where((c) =>
                      (!c.sharedToAll && !c.shared) ||
                      (user?.emailFromLogin == c.owner))
                  .toList();
              final sharedCalendars = state.calendars
                  ?.where((c) => c.shared && !c.sharedToAll && user?.emailFromLogin != c.owner)
                  .toList();
              final sharedToAllCalendars =
                  state.calendars?.where((c) => c.shared && c.sharedToAll && user?.emailFromLogin != c.owner).toList();
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
                                      showPermission: false,
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
                    if (sharedCalendars?.isNotEmpty ?? false)
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
                    if (sharedToAllCalendars?.isNotEmpty ?? false)
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
                    const SizedBox(
                      height: 24,
                    ),
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
  final bool showPermission;
  final bool isChecked;
  final Function(bool?) onChanged;

  CollapsibleCheckboxList(
      {this.showPermission = true,
      required this.calendar,
      required this.onChanged,
      required this.isChecked});

  @override
  _CollapsibleCheckboxListState createState() =>
      _CollapsibleCheckboxListState();
}

enum _CalendarDrawerMenuItems{
  getLink,
  edit,
  download,
  unsubscribe,
  share,
  delete
}

class _CollapsibleCheckboxListState extends State<CollapsibleCheckboxList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late AnimationController _animationController;
  List<_MenuItem> _menuItems = [];
  late final String _currentUserMail;


  @override
  void initState() {
    super.initState();
    _currentUserMail =
        BlocProvider.of<AuthBloc>(context).currentUser?.emailFromLogin ?? '';
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

  _MenuItem _menuItemBuilder(_CalendarDrawerMenuItems item) {
    switch (item){
      case _CalendarDrawerMenuItems.getLink:
       return _MenuItem(
         icon: Icon(Icons.link),
         titleBuilder: (ctx) => 'Get a link',
         onTap: (ctx, ViewCalendar calendar) {
           CalendarLinksDialog.show(ctx, calendarId: calendar.id);
         },
       );
      case _CalendarDrawerMenuItems.edit:
       return  _MenuItem(
          icon: Icon(Icons.edit_outlined),
          titleBuilder: (ctx) => S.of(ctx).contacts_view_app_bar_edit_contact,
          onTap: (ctx, ViewCalendar calendar) {
            CalendarEditDialog.show(ctx, calendar: calendar).then((value) {
              if (value != null) {
                BlocProvider.of<CalendarsBloc>(ctx)
                    .add(UpdateCalendar(value));
              }
            });
          },
        );
      case _CalendarDrawerMenuItems.download:
        return _MenuItem(
          icon: Icon(Icons.file_download_outlined),
          titleBuilder: (ctx) => 'Import ICS file',
          onTap: (ctx, ViewCalendar calendar) {},
        );
      case _CalendarDrawerMenuItems.unsubscribe:
        return _MenuItem(
          icon: Icon(Icons.unsubscribe_outlined),
          titleBuilder: (ctx) => 'Unsubscribe from calendar',
          onTap: (ctx, ViewCalendar calendar) {},
        );
      case _CalendarDrawerMenuItems.share:
        return _MenuItem(
          icon: Icon(Icons.group_add_outlined),
          titleBuilder: (ctx) => S.of(ctx).btn_share,
          onTap: (ctx, ViewCalendar calendar) {
            CalendarSharingDialog.show(context, calendar: calendar).then((value) {
              if(value == null) return;
              BlocProvider.of<CalendarsBloc>(ctx)
                  .add(UpdateCalendarShares(calendarId: calendar.id ,shares: value));
            });
          },
        );
      case _CalendarDrawerMenuItems.delete:
        return _MenuItem(
          icon: Icon(Icons.delete_outline),
          titleBuilder: (ctx) => S.of(ctx).btn_delete,
          onTap: (ctx, ViewCalendar calendar) {
            CalendarConfirmDialog.show(ctx,
                title: 'Delete calendar',
                confirmMessage:
                "Are you sure you want to delete calendar ${calendar.name}?")
                .then((value) {
              if (value != true) return;
              BlocProvider.of<CalendarsBloc>(ctx)
                  .add(DeleteCalendar(calendar));
              Navigator.of(ctx).pop();
            });
          },
        );
    }
  }




  List<_MenuItem> _buildSharedToAllAccessReadMenuItems() {
    return [
      _menuItemBuilder(_CalendarDrawerMenuItems.getLink)
    ];
  }

  List<_MenuItem> _buildSharedToAllAccessWriteMenuItems() {
    return [
      _menuItemBuilder(_CalendarDrawerMenuItems.edit),
      _menuItemBuilder(_CalendarDrawerMenuItems.download),
      _menuItemBuilder(_CalendarDrawerMenuItems.getLink),
    ];
  }

  List<_MenuItem> _buildSharedAccessReadMenuItems() {
    return [
      _menuItemBuilder(_CalendarDrawerMenuItems.getLink),
      _menuItemBuilder(_CalendarDrawerMenuItems.unsubscribe),
    ];
  }

  List<_MenuItem> _buildSharedAccessWriteMenuItems() {
    return [
      _menuItemBuilder(_CalendarDrawerMenuItems.edit),
      _menuItemBuilder(_CalendarDrawerMenuItems.download),
      _menuItemBuilder(_CalendarDrawerMenuItems.getLink),
      _menuItemBuilder(_CalendarDrawerMenuItems.share),
      _menuItemBuilder(_CalendarDrawerMenuItems.unsubscribe),
    ];
  }

  List<_MenuItem> _buildDefaultMenuItems() {
    return [
      _menuItemBuilder(_CalendarDrawerMenuItems.edit),
      _menuItemBuilder(_CalendarDrawerMenuItems.download),
      _menuItemBuilder(_CalendarDrawerMenuItems.getLink),
      _menuItemBuilder(_CalendarDrawerMenuItems.share),
      _menuItemBuilder(_CalendarDrawerMenuItems.delete),
    ];
  }

  List<_MenuItem> _buildMenuItems() {
    if (widget.calendar.sharedToAll && widget.calendar.owner != _currentUserMail) {
      if (widget.calendar.sharedToAllAccess == 2) {
        return _buildSharedToAllAccessReadMenuItems();
      } else if (widget.calendar.sharedToAllAccess == 1) {
        return _buildSharedToAllAccessWriteMenuItems();
      } else {
        return [];
      }
    } else if (widget.calendar.shared && widget.calendar.owner != _currentUserMail) {
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
                      if (widget.calendar.name.isNotEmpty &&
                          (widget.calendar.shared ||
                              widget.calendar.sharedToAll))
                        Text(
                          '${widget.calendar.name} - ${widget.calendar.owner}',
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        )
                      else
                        Text(widget.calendar.name),
                      if (((widget.calendar.shared &&
                                  widget.calendar.access == 2 &&
                                  !widget.calendar.sharedToAll) ||
                              (widget.calendar.sharedToAll &&
                                  widget.calendar.sharedToAllAccess == 2)) &&
                          widget.showPermission)
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
                              horizontal: _horizontalSectionPadding,
                              vertical: 0),
                          dense: true,
                          horizontalTitleGap: 0,
                          leading: e.icon,
                          iconColor: Theme.of(context).primaryColor,
                          onTap: () => e.onTap(context, widget.calendar),
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
  final void Function(BuildContext ctx, ViewCalendar calendar) onTap;

  const _MenuItem({
    required this.icon,
    required this.titleBuilder,
    required this.onTap,
  });
}
