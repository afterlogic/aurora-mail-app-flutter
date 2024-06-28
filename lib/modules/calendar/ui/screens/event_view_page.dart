import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/deletion_confirm_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/attendee_card.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum EventViewAppBarAction { edit, delete }

class EventViewPage extends StatelessWidget {
  static const name = "event_view_page";

  EventViewPage({
    super.key,
  });

  void onActionSelected(EventViewAppBarAction action, BuildContext context) {
    switch (action) {
      case EventViewAppBarAction.edit:
        Navigator.of(context).pushNamed(EventCreationPage.name);
        break;
      case EventViewAppBarAction.delete:
        CalendarConfirmDialog.show(context, title: 'Delete event')
            .then((value) {
          if (value != true) return;
          BlocProvider.of<EventsBloc>(context).add(DeleteEvent());
          Navigator.of(context).pop();
        });
        break;
    }
  }

  PopupMenuEntry<EventViewAppBarAction> _buildMenuItem(
      {required EventViewAppBarAction value,
      required String text,
      required IconData icon,
      required BuildContext context}) {
    return PopupMenuItem(
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : null,
        ),
        title: Text(text),
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      PopupMenuButton(
        onSelected: (EventViewAppBarAction action) =>
            onActionSelected(action, context),
        itemBuilder: (ctx) => [
          _buildMenuItem(
              icon: Icons.edit,
              text: S.of(ctx).contacts_view_app_bar_edit_contact,
              value: EventViewAppBarAction.edit,
              context: ctx),
          _buildMenuItem(
              icon: Icons.delete_outline,
              text: S.of(ctx).contacts_view_app_bar_delete_contact,
              value: EventViewAppBarAction.delete,
              context: ctx),
        ],
      ),
    ];
    return Scaffold(
      appBar: AMAppBar(
        title: Text('Event'),
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, eventsState) {
            final areRemindersEmpty =
                (eventsState.selectedEvent?.reminders?.isNotEmpty ?? false);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<CalendarsBloc, CalendarsState>(
                        builder: (context, calendarsState) {
                          final _selectedCalendar = calendarsState.calendars
                              ?.firstWhereOrNull((e) =>
                                  e.id ==
                                  eventsState.selectedEvent?.calendarId);
                          return (_selectedCalendar != null)
                              ? CalendarTile(
                                  circleColor: _selectedCalendar.color,
                                  text: _selectedCalendar.name)
                              : Text('Selected calendar not found');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Title', style: TextStyle(color: Colors.grey)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(eventsState.selectedEvent?.title ?? ''),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Description', style: TextStyle(color: Colors.grey)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(eventsState.selectedEvent?.description ?? ''),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Location', style: TextStyle(color: Colors.grey)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(eventsState.selectedEvent?.location ?? ''),
                    ],
                  ),
                ),
                const Divider(
                  color: const Color(0xFFB6B5B5),
                  height: 1,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        if (eventsState.selectedEvent != null)
                          DateTimeTile(
                            dateTime: eventsState.selectedEvent!.startDate,
                            isAllDay: eventsState.selectedEvent?.allDay ?? true,
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (eventsState.selectedEvent != null)
                          DateTimeTile(
                            dateTime: eventsState.selectedEvent!.endDate,
                            isAllDay: eventsState.selectedEvent?.allDay ?? true,
                          ),
                      ],
                    )),
                const Divider(
                  color: const Color(0xFFB6B5B5),
                  height: 1,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: SectionWithIcon(
                      children: [
                        Row(
                          children: [
                            Text(
                              eventsState.selectedEvent!.recurrenceMode!
                                  .buildString(context),
                            ),
                            Spacer(),
                            if (eventsState.selectedEvent!.recurrenceMode !=
                                RecurrenceMode.never)
                              Text(
                                eventsState.selectedEvent!
                                            .recurrenceUntilDate ==
                                        null
                                    ? 'Always'
                                    : 'until ${DateFormat('yyyy/MM/dd').format(eventsState.selectedEvent!.recurrenceUntilDate!)}',
                              ),
                          ],
                        ),
                      ],
                      icon: Icon(
                        Icons.sync,
                        size: 15,
                      ),
                    )),
                if (areRemindersEmpty)
                  const Divider(
                    color: const Color(0xFFB6B5B5),
                    height: 1,
                  ),
                if (areRemindersEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: SectionWithIcon(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: eventsState.selectedEvent?.reminders !=
                                              null &&
                                          eventsState.selectedEvent!.reminders!
                                                  .length >
                                              1
                                      ? 0.0
                                      : 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (eventsState
                                          .selectedEvent?.reminders?.isEmpty ??
                                      true)
                                    Text(
                                      'Reminders',
                                    ),
                                  ...?eventsState.selectedEvent?.reminders
                                      ?.map((e) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child:
                                                Text('${e.buildString} before'),
                                          ))
                                      .toList()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      icon: Padding(
                        padding: EdgeInsets.only(
                            top: eventsState.selectedEvent?.reminders != null &&
                                    eventsState
                                            .selectedEvent!.reminders!.length >
                                        1
                                ? 0.0
                                : 6.0),
                        child: Icon(
                          Icons.notifications_none,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                if (eventsState.selectedEvent?.attendees.isNotEmpty == true)
                  const Divider(
                    color: const Color(0xFFB6B5B5),
                    height: 1,
                  ),
                if (eventsState.selectedEvent?.attendees.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.group,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Attendees',
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Wrap(runSpacing: 4, spacing: 4, children: [
                          ...eventsState.selectedEvent!.attendees.map(
                            (e) =>
                                LayoutBuilder(builder: (context, constraints) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: (constraints.maxWidth / 2) - 4,
                                ),
                                child: AttendeeCard(
                                  attendee: e,
                                  onDelete: null,
                                ),
                              );
                            }),
                          ),
                        ]),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
