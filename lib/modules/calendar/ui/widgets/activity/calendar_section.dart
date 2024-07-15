import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class CalendarSection extends StatelessWidget {
  final String? calendarId;

  const CalendarSection({super.key, required this.calendarId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarsBloc, CalendarsState>(
      builder: (context, calendarsState) {
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
