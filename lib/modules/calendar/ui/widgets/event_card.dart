import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'month_event_marker.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final ViewEvent event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        BlocProvider.of<EventsBloc>(context).add(SelectEvent(event));
        Navigator.of(context).pushNamed(
          EventViewPage.name,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '${event.title}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    color: event.color),
              ),
              const SizedBox(
                width: 4,
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  final dateFormat =
                      (state is SettingsLoaded) && (state.is24 == true)
                          ? DateFormat('HH:mm')
                          : DateFormat("hh:mm a");
                  return event.allDay == true
                      ? Text('All day',
                          style: TextStyle(
                            color: Color.fromRGBO(150, 148, 148, 1),
                          ))
                      : Text(
                          '${dateFormat.format(event.startDate)} - ${dateFormat.format(event.endDate)}',
                          style: TextStyle(
                            color: Color.fromRGBO(150, 148, 148, 1),
                          ),
                        );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
