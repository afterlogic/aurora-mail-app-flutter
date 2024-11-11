import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class CalendarSection extends StatelessWidget {
  final String? calendarId;
  final bool isEditable;
  final String? currentUserMail;
  final ViewCalendar? selectedCalendar;
  final void Function(ViewCalendar calendar)? selectCalendarCallback;

  const CalendarSection(
      {super.key,
      this.isEditable = false,
      this.currentUserMail,
      this.selectCalendarCallback,
      this.selectedCalendar,
      required this.calendarId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarsBloc, CalendarsState>(
      builder: (context, calendarsState) {
        if (isEditable) {
          return GestureDetector(
            onTap: () {
              CalendarSelectDialog.show(context,
                      initialValue: selectedCalendar,
                      options: calendarsState
                          .availableCalendars(currentUserMail ?? ''))
                  .then((value) {
                if (value != null) selectCalendarCallback!.call(value);
              });
            },
            child: (selectedCalendar != null)
                ? CalendarTile(
                    circleColor: selectedCalendar!.color,
                    text: selectedCalendar!.name)
                : TextButton(onPressed: null, child: Text('Select calendar')),
          );
        }
        final _selectedCalendar = calendarsState.calendars
            ?.firstWhereOrNull((e) => e.id == calendarId);
        return (_selectedCalendar != null)
            ? CalendarTile(
                circleColor: _selectedCalendar.color,
                text: _selectedCalendar.name)
            : Text('Selected calendar not found');
      },
    );
  }
}
