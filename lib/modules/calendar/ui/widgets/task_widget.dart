import 'package:aurora_mail/modules/calendar/blocs/tasks/tasks_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/task_view_page.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidget extends StatelessWidget {
  final ViewTask task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<SettingsBloc>(context).state;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        BlocProvider.of<TasksBloc>(context).add(SelectTask(task));
        Navigator.of(context).pushNamed(
          TaskViewPage.name,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: task.color,
                width: 2,
              ),
              color: (task.status ?? false) ? task.color : Colors.transparent,
            ),
            child: (task.status ?? false)
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.subject ?? '',
                  style: TextStyle(
                      decoration: (task.status ?? false)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: 16),
                ),
                if (task.startTS != null && task.endTS != null)
                  Text(
                    '${DateFormatting.formatEventDates(
                      startDate: task.startTS!,
                      endDate: task.endTS!,
                      is24: (state as SettingsLoaded).is24 ?? true,
                    )}',
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
