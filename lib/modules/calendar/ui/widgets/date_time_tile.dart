import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateTimeTile extends StatelessWidget {
  const DateTimeTile(
      {super.key,
      required this.dateTime,
      this.onChanged,
      required this.isAllDay});

  final Function(DateTime)? onChanged;
  final DateTime? dateTime;
  final bool isAllDay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null
          ? () {
              showDatePicker(
                      context: context,
                      initialDate: dateTime ?? DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2040))
                  .then((value) {
                if (value != null && !isAllDay) {
                  final DateTime result = dateTime == null
                      ? value
                      : dateTime!.copyWith(
                          year: value.year, month: value.month, day: value.day);
                  showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(result))
                      .then((value) {
                    if (value != null) {
                      onChanged!(result.copyWith(
                          hour: value.hour, minute: value.minute));
                    } else {
                      onChanged!(result);
                    }
                  });
                } else if (value != null && isAllDay) {
                  final DateTime result = value.copyWith(
                      hour: 12,
                      minute: 0,
                      second: 0,
                      millisecond: 0,
                      microsecond: 0);
                  onChanged!(result);
                }
              });
            }
          : null,
      child: dateTime == null
          ? Text('No date selected')
          : Row(
              children: [
                Text(DateFormat('E, MMM d, y').format(dateTime!)),
                Spacer(),
                if (!isAllDay)
                  BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      return (state is SettingsLoaded) && (state.is24 == true)
                          ? Text(DateFormat('HH:mm').format(dateTime!))
                          : Text(DateFormat.jm().format(dateTime!));
                    },
                  ),
              ],
            ),
    );
  }
}
