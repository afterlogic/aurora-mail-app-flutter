import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'month_event_marker.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final ViewEvent event;

  @override
  Widget build(BuildContext context) {
    return event is VisibleDayEvent
        ? Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${(event as VisibleDayEvent).title}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                          color: (event as VisibleDayEvent).color),
                    ),
                   const SizedBox(width: 4,),
                    Text(
                      DateFormat("hh:mm a").format((event as VisibleDayEvent).startDate),
                      style: TextStyle(
                        color: Color.fromRGBO(150, 148, 148, 1),
                      ),
                    )
                  ],
                )
              ],
            ),
        )
        : const SizedBox();
  }
}
