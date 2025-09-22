import 'package:aurora_mail/build_property.dart';
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
import 'package:aurora_mail/shared_ui/app_bar_icons.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_color.dart';

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
        CalendarConfirmDialog.show(context,
                title: S.of(context).calendar_delete_event_title)
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
      required Widget icon,
      required BuildContext context}) {
    return PopupMenuItem(
      child: ListTile(
        leading: icon,
        title: Text(text),
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      PopupMenuButton(
        icon: AppBarIcons.menu(context: context),
        onSelected: (EventViewAppBarAction action) =>
            onActionSelected(action, context),
        itemBuilder: (ctx) => [
          _buildMenuItem(
              icon: AppBarIcons.edit(context: ctx),
              text: S.of(ctx).contacts_view_app_bar_edit_contact,
              value: EventViewAppBarAction.edit,
              context: ctx),
          _buildMenuItem(
              icon: AppBarIcons.delete(context: ctx),
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
            title: Text(S.of(context).calendar_event_title),
            shadow: BoxShadow(color: Colors.transparent),
            leading: IconButton(
              icon: AppBarIcons.back(context: context),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
                          if (BuildProperty.useAppBarDivider)
                            Container(
                              height: 1,
                              color: AppColor.appBarDivider,
                            ),
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
