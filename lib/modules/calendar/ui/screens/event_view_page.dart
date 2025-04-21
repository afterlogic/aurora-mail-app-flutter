import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/notification/calendar_notification_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/deletion_confirm_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/attendees_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/calendar_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/date_info.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/main_info.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/recurrence_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/reminders_section.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/activity/section_divider.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<CalendarNotificationBloc, CalendarNotificationState>(
      buildWhen: (prev, curr) =>
          prev.notificationSyncStatus != curr.notificationSyncStatus,
      builder: (context, state) {
        return Scaffold(
          appBar: AMAppBar(
            title: Text('Event'),
            backgroundColor: Color(0xFFF4F1FD),
            textStyle:TextStyle(color: Color(0xFF2D2D2D), fontSize: 18, fontWeight: FontWeight.w600),
            shadow: BoxShadow(color: Colors.transparent),
            actions: state.notificationSyncStatus.isLoading ? null : actions,
          ),
          body: state.notificationSyncStatus.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: BlocBuilder<EventsBloc, EventsState>(
                    builder: (context, eventsState) {
                      final areRemindersNotEmpty =
                          (eventsState.selectedEvent?.reminders?.isNotEmpty ??
                              false);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CalendarSection(
                                    calendarId:
                                        eventsState.selectedEvent?.calendarId),
                                const SizedBox(
                                  height: 20,
                                ),
                                MainInfo(
                                    description:
                                        eventsState.selectedEvent?.description,
                                    location:
                                        eventsState.selectedEvent?.location,
                                    title: eventsState.selectedEvent?.title),
                              ],
                            ),
                          ),
                          const SectionDivider(),
                          if (eventsState.selectedEvent != null)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: DateInfo(
                                    displayable: eventsState.selectedEvent!)),
                          if (eventsState.selectedEvent != null)
                            const SectionDivider(),
                          if (eventsState.selectedEvent != null)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 24),
                                child: RecurrenceSection(
                                    activity: eventsState.selectedEvent!)),
                          if (areRemindersNotEmpty) const SectionDivider(),
                          if (areRemindersNotEmpty)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: RemindersSection(
                                    reminders:
                                        eventsState.selectedEvent!.reminders)),
                          if (eventsState.selectedEvent?.attendees.isNotEmpty ==
                              true)
                            const SectionDivider(),
                          if (eventsState.selectedEvent?.attendees.isNotEmpty ==
                              true)
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                child: AttendeesSection(
                                  attendees:
                                      eventsState.selectedEvent!.attendees,
                                )),
                        ],
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
