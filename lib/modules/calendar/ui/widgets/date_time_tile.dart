import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeTile extends StatelessWidget {
  const DateTimeTile(
      {super.key, required this.dateTime, this.onChanged});

  final Function(DateTime)? onChanged;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () {
        showDatePicker(
            context: context,
            initialDate: dateTime,
            firstDate: DateTime(1980),
            lastDate: DateTime(2040))
            .then((value) {
          if (value != null) {
            final DateTime result = dateTime.copyWith(
                year: value.year, month: value.month, day: value.day);
            showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(dateTime))
                .then((value) {
              if (value != null) {
                onChanged!(
                    result.copyWith(hour: value.hour, minute: value.minute));
              } else {
                onChanged!(result);
              }
            });
          }
        });
      },
      child: Row(
        children: [
          Text(DateFormat('E, MMM d, y').format(dateTime)),
          Spacer(),
          Text(DateFormat.jm().format(dateTime)),
        ],
      ),
    );
  }
}
