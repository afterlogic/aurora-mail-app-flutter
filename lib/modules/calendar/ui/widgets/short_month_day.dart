import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ShortMonthDay extends StatelessWidget {
  const ShortMonthDay(
      {super.key,
      required this.height,
      required this.dayNumber,
      required this.showEventMarker,
      this.events = const [],
      required this.currentDate,
      required this.boxColor,
      required this.eventsMarkerColor,
      required this.dayNumberColor});

  final double height;
  final List<ViewEvent?> events;
  final DateTime currentDate;
  final String dayNumber;
  final bool showEventMarker;
  final Color boxColor;
  final Color eventsMarkerColor;
  final Color dayNumberColor;
  final double _markerDiameter = 5.0;

  @override
  Widget build(BuildContext context) {
    final availableEvents = events.length >= 3 ? events.getRange(0, 3) : events;
    final hiddenEvents = events.length <= 3
        ? []
        : events.skip(3).where((e) => e != null).toList();
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4.0),
            height: showEventMarker && events.whereNotNull().isNotEmpty
                ? height
                : height - _markerDiameter,
            width: height,
            decoration: BoxDecoration(
                color: boxColor, borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: [
                Text(
                  dayNumber,
                  style: TextStyle(color: dayNumberColor, fontSize: 18),
                ),
                const SizedBox(
                  height: 2,
                ),
                if (showEventMarker && events.whereNotNull().isNotEmpty)
                  Container(
                    width: _markerDiameter,
                    height: _markerDiameter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_markerDiameter),
                        color: eventsMarkerColor),
                  ),
              ],
            ),
          ),
          if (!showEventMarker)
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Column(children: [
                ...availableEvents
                    .map<Widget>(
                      (e) => MonthEventMarker(
                        event: e,
                        currentDate: currentDate,
                      ),
                    )
                    .toList(),
                if (hiddenEvents.isNotEmpty && availableEvents.where((e) => e != null).isNotEmpty)
                  Transform.translate(
                    offset: Offset(0, -3),
                    child: Icon(
                      Icons.more_horiz,
                      size: 14,
                    ),
                  ),
              ]),
            )
        ],
      ),
    );
  }
}
