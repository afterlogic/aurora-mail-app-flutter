import 'package:flutter/material.dart';

class ShortMonthDay extends StatelessWidget {
  const ShortMonthDay(
      {super.key,
      required this.height,
      required this.dayNumber,
      required this.hasEvents,
      required this.boxColor,
      required this.eventsMarkerColor,
      required this.dayNumberColor});

  final double height;
  final String dayNumber;
  final bool hasEvents;
  final Color boxColor;
  final Color eventsMarkerColor;
  final Color dayNumberColor;
  final double _markerDiameter = 5.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(4.0),
        height: hasEvents ? height : height - _markerDiameter,
        width: height,
        decoration: BoxDecoration(
            color: boxColor, borderRadius: BorderRadius.circular(4)),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Text(
              dayNumber,
              style: TextStyle(color: dayNumberColor, fontSize: 18),
            ),
            const SizedBox(
              height: 2,
            ),
            if (hasEvents)
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
    );
  }
}
