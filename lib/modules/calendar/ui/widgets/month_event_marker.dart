import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_creation_page.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class MonthEventMarker extends StatelessWidget {
  const MonthEventMarker(
      {super.key,
      required this.event,
      this.height = 15,
      required this.currentDate,
      this.eventGap = 2});

  final ViewEvent? event;
  final double eventGap;
  final double height;
  final DateTime currentDate;
  final radius = 4.0;

  double get emptyHeight => eventGap + height;

  @override
  Widget build(BuildContext context) {
    return event is ExtendedMonthEvent
        ? GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(EventViewPage.name,
                  arguments: EventViewPageArg(
                      event: event!));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: event?.isStartedToday(currentDate) == true ? 4.0 : 0,
                  right: event?.isEndedToday(currentDate) == true ? 4.0 : 0),
              child: Container(
                  margin: EdgeInsets.only(bottom: eventGap),
                  padding: EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: event?.isStartedToday(currentDate) == true
                            ? Radius.circular(radius)
                            : Radius.zero,
                        bottomLeft: event?.isStartedToday(currentDate) == true
                            ? Radius.circular(radius)
                            : Radius.zero,
                        topRight: event?.isEndedToday(currentDate) == true
                            ? Radius.circular(radius)
                            : Radius.zero,
                        bottomRight: event?.isEndedToday(currentDate) == true
                            ? Radius.circular(radius)
                            : Radius.zero,
                      ),
                      color: (event as ExtendedMonthEvent).color),
                  width: 60,
                  height: height,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      event?.isStartedToday(currentDate) == true
                          ? (event as ExtendedMonthEvent).title
                          : '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )),
            ),
          )
        : SizedBox(
            height: emptyHeight,
          );
  }

  BorderRadius? _calculateBorderRadius(Edge edge) {
    final radius = 4.0;
    switch (edge) {
      case Edge.start:
        return BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius));
      case Edge.single:
        return BorderRadius.all(Radius.circular(radius));
      case Edge.end:
        return BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius));
      case Edge.part:
        return null;
    }
  }
}

class _EventText extends StatelessWidget {
  const _EventText({required this.edge, required this.title});

  final String title;
  final Edge edge;

  @override
  Widget build(BuildContext context) {
    return Text(
      edge.isSingle || edge.isStart ? title : "",
      style: TextStyle(fontSize: 10, color: Colors.white),
    );
  }
}
