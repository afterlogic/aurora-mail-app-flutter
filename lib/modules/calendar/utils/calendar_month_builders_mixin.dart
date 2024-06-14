import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/short_month_day.dart';
import 'package:flutter/material.dart';

mixin CalendarMonthBuilders {
  Widget? extendedModeBuilder(
      List<ViewEvent?> events, double topPadding, DateTime currentDate) {
    if (events.isEmpty) {
      return null;
    }
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: events
            .map<Widget>(
              (e) => MonthEventMarker(
                event: e,
                currentDate: currentDate,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget disabledDayBuilder(
    BuildContext context,
    DateTime currentDate, {
    required double cellHeight,
    required List<ViewEvent?> events,
  }) {
    return ShortMonthDay(
      height: cellHeight,
      dayNumber: currentDate.day.toString(),
      showEventMarker: false,
      currentDate: currentDate,
      events: events,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor.withOpacity(0.5),
      dayNumberColor: Colors.grey.shade300,
    );
  }

  Widget outsideDayBuilder(
    BuildContext context,
    DateTime currentDate, {
    required bool showEventMarker,
    required List<ViewEvent?> events,
    required double cellHeight,
  }) {
    return ShortMonthDay(
      height: cellHeight,
      dayNumber: currentDate.day.toString(),
      currentDate: currentDate,
      events: events,
      showEventMarker: showEventMarker,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor.withOpacity(0.5),
      dayNumberColor: Colors.grey,
    );
  }

  Widget defaultDayBuilder(
    BuildContext context,
    DateTime currentDate, {
    required bool showEventMarker,
    required List<ViewEvent?> events,
    required double cellHeight,
  }) {
    return ShortMonthDay(
      height: cellHeight,
      dayNumber: currentDate.day.toString(),
      showEventMarker: showEventMarker,
      currentDate: currentDate,
      events: events,
      boxColor: Colors.transparent,
      eventsMarkerColor: Theme.of(context).primaryColor,
      dayNumberColor: Colors.black,
    );
  }

  Widget selectedDayBuilder(
    BuildContext context,
    DateTime currentDate, {
    required bool showEventMarker,
    required List<ViewEvent?> events,
    required double cellHeight,
  }) {
    return ShortMonthDay(
      height: cellHeight,
      dayNumber: currentDate.day.toString(),
      currentDate: currentDate,
      events: events,
      showEventMarker: showEventMarker,
      boxColor: Color.fromARGB(255, 209, 230, 253),
      eventsMarkerColor: Theme.of(context).primaryColor,
      dayNumberColor: Theme.of(context).primaryColor,
    );
  }

  Widget todayDayBuilder(
    BuildContext context,
    DateTime currentDate, {
    required bool showEventMarker,
    required List<ViewEvent?> events,
    required double cellHeight,
  }) {
    return ShortMonthDay(
      height: cellHeight,
      currentDate: currentDate,
      events: events,
      dayNumber: currentDate.day.toString(),
      showEventMarker: showEventMarker,
      boxColor: Color.fromARGB(255, 240, 150, 80),
      eventsMarkerColor: Colors.white,
      dayNumberColor: Colors.white,
    );
  }
}
