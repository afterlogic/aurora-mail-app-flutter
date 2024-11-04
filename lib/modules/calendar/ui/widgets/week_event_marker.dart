import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:flutter/material.dart';

class WeekEventMarker extends StatelessWidget {
  const WeekEventMarker({
    super.key,
    required this.event,
    this.fontSize = 12,
    this.radius = 6.0,
    this.innerPaddingValue = 4.0,
    required this.currentDate,
  });

  final ViewEvent? event;
  final DateTime currentDate;
  final double fontSize;
  final double radius;
  final double innerPaddingValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement contrast color detection
    final textColor = Colors.white;

    return Container(
      margin: EdgeInsets.only(
        left: 1,
        right: 1,
        top: event?.isStartedToday(currentDate) == true ? 1 : 0,
        bottom: event?.isEndedToday(currentDate) == true ? 1 : 0,
      ),
      padding: EdgeInsets.only(left: innerPaddingValue, top: innerPaddingValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft:
            event?.isStartedToday(currentDate) == true
                ? Radius.circular(radius)
                : Radius.zero,
          topRight:
            event?.isStartedToday(currentDate) == true
                ? Radius.circular(radius)
                : Radius.zero,
          bottomLeft:
            event?.isEndedToday(currentDate) == true
                ? Radius.circular(radius)
                : Radius.zero,
          bottomRight:
            event?.isEndedToday(currentDate) == true
                ? Radius.circular(radius)
                : Radius.zero,
        ),
        color: event!.color
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            if (event?.isStartedToday(currentDate) == true &&
                event?.recurrenceMode != null &&
                event?.recurrenceMode != RecurrenceMode.never)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.repeat,
                  size: 8,
                  color: textColor,
                ),
            ),
            Expanded(
              child: Text(
                event!.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
