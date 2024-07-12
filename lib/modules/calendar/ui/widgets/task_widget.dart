import 'package:aurora_mail/modules/calendar/ui/models/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  final ViewTask task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
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
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.subject ?? '',
                style: TextStyle(
                  decoration:
                  (task.status ?? false) ? TextDecoration.lineThrough : TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              if (task.startTS != null && task.endTS != null)
                Text(
                  '${DateFormat('h:mm a').format(task.startTS!)} - ${DateFormat('h:mm a').format(task.endTS!)}',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ],
    );
  }
}