import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'month_event_marker.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final ViewEvent event;

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                Text(
                  '${DateFormat("hh:mm a").format(event.startDate)} - ${DateFormat("hh:mm a").format(event.endDate)}',
                  style: TextStyle(
                    color: Color.fromRGBO(150, 148, 148, 1),
                  ),
                )
              ],
            )
          ],
        );
       
  }
}
