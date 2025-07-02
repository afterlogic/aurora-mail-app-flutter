import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/blocs/notification/calendar_notification_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/tasks/tasks_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/deletion_confirm_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_creation_page.dart';
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

class TaskViewPage extends StatelessWidget {
  static const name = "task_view_page";

  TaskViewPage({
    super.key,
  });

  void onActionSelected(EventViewAppBarAction action, BuildContext context) {
    switch (action) {
      case EventViewAppBarAction.edit:
        Navigator.of(context).pushNamed(TaskCreationPage.name);
        break;
      case EventViewAppBarAction.delete:
        CalendarConfirmDialog.show(context, title: 'Delete task').then((value) {
          if (value != true) return;
          BlocProvider.of<TasksBloc>(context).add(DeleteTask());
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
            title: Text('Task'),
            backgroundColor: AppColor.appBarBackground,
            shadow: BoxShadow(color: Colors.transparent),
            actions: state.notificationSyncStatus.isLoading ? null : actions,
          ),
          body: state.notificationSyncStatus.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : BlocBuilder<TasksBloc, TasksState>(
                  builder: (context, tasksState) {
                    final isComplete = tasksState.selectedTask?.status == true;
                    final areRemindersNotEmpty =
                        (tasksState.selectedTask?.reminders?.isNotEmpty ??
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
                                      tasksState.selectedTask?.calendarId),
                              const SizedBox(
                                height: 20,
                              ),
                              MainInfo(
                                  description:
                                      tasksState.selectedTask?.description,
                                  location: tasksState.selectedTask?.location,
                                  title: tasksState.selectedTask?.subject),
                            ],
                          ),
                        ),
                        const SectionDivider(),
                        if (tasksState.selectedTask != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: DateInfo(
                                  displayable: tasksState.selectedTask!)),
                        if (tasksState.selectedTask != null)
                          const SectionDivider(),
                        if (tasksState.selectedTask != null)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              child: RecurrenceSection(
                                  activity: tasksState.selectedTask!)),
                        if (areRemindersNotEmpty) const SectionDivider(),
                        if (areRemindersNotEmpty)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: RemindersSection(
                                  reminders:
                                      tasksState.selectedTask!.reminders)),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}
