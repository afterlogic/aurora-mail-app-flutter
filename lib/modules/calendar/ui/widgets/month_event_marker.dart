import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
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
    final isSingle = event != null &&
        event!.startDate.withoutTime
            .isAtSameMomentAs(currentDate.withoutTime) &&
        event!.endDate.withoutTime.isAtSameMomentAs(currentDate.withoutTime);
    return event is VisibleDayEvent
        ? Container(
            margin: EdgeInsets.only(bottom: eventGap),
            decoration: BoxDecoration(
                borderRadius:
                    _calculateBorderRadius((event as VisibleDayEvent).edge),
                color: (event as VisibleDayEvent).color),
            width: 60,
            height: height,
            padding: EdgeInsets.only(left: 4),
            child: Align(
                alignment: Alignment.centerLeft,
                child: _EventText(
                  title: (event as VisibleDayEvent).title,
                  edge: (event as VisibleDayEvent).edge,
                )),
          )
        : event is TestEvent
            ? Padding(
                padding: isSingle
                    ? EdgeInsets.symmetric(horizontal: 2)
                    : event!.startDate.withoutTime
                            .isAtSameMomentAs(currentDate.withoutTime)
                        ? EdgeInsets.only(left: 2)
                        : event!.endDate.withoutTime
                                .isAtSameMomentAs(currentDate.withoutTime)
                            ? EdgeInsets.only(right: 2)
                            : EdgeInsets.zero,
                child: Container(
                    margin: EdgeInsets.only(bottom: eventGap),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: event!.startDate.withoutTime
                                  .isAtSameMomentAs(currentDate.withoutTime)
                              ? Radius.circular(radius)
                              : Radius.zero,
                          bottomLeft: event!.startDate.withoutTime
                                  .isAtSameMomentAs(currentDate.withoutTime)
                              ? Radius.circular(radius)
                              : Radius.zero,
                          topRight: event!.endDate.withoutTime
                                  .isAtSameMomentAs(currentDate.withoutTime)
                              ? Radius.circular(radius)
                              : Radius.zero,
                          bottomRight: event!.endDate.withoutTime
                                  .isAtSameMomentAs(currentDate.withoutTime)
                              ? Radius.circular(radius)
                              : Radius.zero,
                        ),
                        color: (event as TestEvent).color),
                    width: 60,
                    height: height,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        event!.startDate.withoutTime
                                .isAtSameMomentAs(currentDate.withoutTime)
                            ? (event as TestEvent).title
                            : '',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )),
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
