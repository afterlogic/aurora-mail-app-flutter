import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekEventMarker extends StatelessWidget {
  const WeekEventMarker({
    super.key,
    required this.event,
    this.height = 15,
    this.fontSize = 10,
    this.implementLeftBorder = false,
    this.implementBorder = false,
    this.forceTitleRender = false,
    this.radius = 4.0,
    this.innerPaddingValue = 4.0,
    required this.currentDate,
    this.eventGap = 2
  });

  final ViewEvent? event;
  final bool implementLeftBorder;
  final bool implementBorder;
  final double eventGap;
  final double height;
  final DateTime currentDate;
  final bool forceTitleRender;
  final double fontSize;
  final double radius;
  final double innerPaddingValue;

  double get emptyHeight => eventGap + height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          right: implementBorder && event?.isEndedToday(currentDate) == true
            ? BorderSide(color: Color(0xffdddddd))
            : BorderSide.none,
          left: implementLeftBorder && implementBorder && event?.isStartedToday(currentDate) == true
            ? BorderSide(color: Color(0xffdddddd))
            : BorderSide.none
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: event?.isStartedToday(currentDate) == true
            ? innerPaddingValue
            : 0,
          right: event?.isEndedToday(currentDate) == true
            ? innerPaddingValue
            : 0,
          top: innerPaddingValue,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          padding: EdgeInsets.only(left: 6, top: 4),
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
              color: event!.color),
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
                        color: Colors.white,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      forceTitleRender || event?.isStartedToday(currentDate) == true
                        ? event!.title
                        : '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
    );
  }
}
