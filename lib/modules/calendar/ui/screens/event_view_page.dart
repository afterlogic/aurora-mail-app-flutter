import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/date_time_tile.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/section_with_icon.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EventViewPageArg{
  final ViewEvent event;
  const EventViewPageArg({
    required this.event,
  });
}

class EventViewPage extends StatelessWidget {
  final EventViewPageArg arg;
  static const name = "event_view_page";

  const EventViewPage({super.key, required this.arg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text('Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CalendarsBloc, CalendarsState>(
                    builder: (context, state) {
                      final _selectedCalendar = state.calendars?.firstWhereOrNull((e) => e.id == arg.event.calendarId);
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
                  Text(arg.event.title),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Description', style: TextStyle(color: Colors.grey)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(''),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Location', style: TextStyle(color: Colors.grey)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(''),
                ],
              ),
            ),
            const Divider(
              color: const Color(0xFFB6B5B5),
              height: 1,
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    DateTimeTile(
                        dateTime: arg.event.startDate,
                        onChanged: (DateTime value) {
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    DateTimeTile(
                        dateTime: arg.event.endDate,
                        onChanged: (DateTime value) {
                        }),],
                )),
            const Divider(
              color: const Color(0xFFB6B5B5),
              height: 1,
            ),
            Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: SectionWithIcon(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Daily',
                        ),
                        Spacer(),
                        Text(
                          'Always',
                        ),
                      ],
                    ),
                  ],
                  icon: Icon(
                    Icons.sync,
                    size: 15,
                  ),
                )),
            const Divider(
              color: const Color(0xFFB6B5B5),
              height: 1,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SectionWithIcon(
                children: [
                  Row(
                    children: [
                      Text(
                        'Reminders',
                      ),
                      const Spacer(),

                    ],
                  ),
                ],
                icon: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Icon(
                    Icons.notifications_none,
                    size: 15,
                  ),
                ),
              ),
            ),
            const Divider(
              color: const Color(0xFFB6B5B5),
              height: 1,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SectionWithIcon(
                children: [
                  Row(
                    children: [
                      Text(
                        'Attendees',
                      ),

                    ],
                  ),
                ],
                icon: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Icon(
                    Icons.group,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}


