import 'package:aurora_mail/modules/calendar/models/event.dart';
import 'package:flutter/material.dart';

class MonthEventMarker extends StatelessWidget {
  const MonthEventMarker(
      {super.key, required this.event, this.height = 15, this.eventGap = 2});

  final CalendarEvent event;
  final double eventGap;
  final double height;

  double get emptyHeight => eventGap + height;

  @override
  Widget build(BuildContext context) {
    return event is Event
        ? Container(
            margin: EdgeInsets.only(bottom: eventGap),
            decoration: BoxDecoration(
                borderRadius: _calculateBorderRadius((event as Event).edge),
                color: generateColorFromString((event as Event).title)),
            width: 60,
            height: height,
            padding: EdgeInsets.only(left: 4),
            child: Align(
                alignment: Alignment.centerLeft,
                child: _EventText(
                  title: (event as Event).title,
                  edge: (event as Event).edge,
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

Color generateColorFromString(String input) {
  int hashCode = input.hashCode;

  // Extract RGB values from the hash code
  int red = (hashCode & 0xFF0000) >> 16;
  int green = (hashCode & 0x00FF00) >> 8;
  int blue = hashCode & 0x0000FF;

  return Color.fromARGB(255, red, green, blue);
}
