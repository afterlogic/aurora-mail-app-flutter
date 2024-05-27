import 'dart:ui';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';

abstract class ViewEvent {
  final DateTime startDate;
  final DateTime endDate;
  const ViewEvent({required this.startDate, required this.endDate});
}

class VisibleDayEvent extends ViewEvent {
  final String title;
  final String id;
  final Edge edge;
  final bool isAllDay;
  final Color color;

  const VisibleDayEvent(
      {this.edge = Edge.single,
      required this.title,
      required this.id,
      required super.startDate,
      required super.endDate,
      required this.color,
      this.isAllDay = false});

  static VisibleDayEvent? tryFromEvent(Event model, {required Color color}) {
    try {
      return VisibleDayEvent(
          title: model.subject!,
          id: model.uid,
          startDate: model.startTS!,
          endDate: model.endTS!,
          color: color);
    } catch (e) {
      return null;
    }
  }

  VisibleDayEvent _normalise() {
    if (!startDate.startOfNextDay.isAtSameMomentAs(endDate)) {
      return this;
    }
    return copyWith(endDate: endDate.subtract(Duration(seconds: 1)));
  }

  List<VisibleDayEvent> get splitIntoDailyEvents {
    List<VisibleDayEvent> dailyEvents = [];
    final event = _normalise();

    DateTime currentStart = event.startDate;
    DateTime currentEnd;

    // if event starts and ends at same day
    if ((event.startDate.year == event.endDate.year &&
        event.startDate.month == event.endDate.month &&
        event.startDate.day == event.endDate.day)) {
      dailyEvents.add(event);
      return dailyEvents;
    }

    bool isFirstEvent = true;

    while (currentStart.isBefore(event.endDate)) {
      // set end of day OR event
      currentEnd = DateTime(
        currentStart.year,
        currentStart.month,
        currentStart.day,
        23,
        59,
        59,
      );

      if (currentEnd.isAfter(event.endDate) ||
          currentEnd.isAtSameMomentAs(event.endDate)) {
        currentEnd = event.endDate;
      }

      bool isLastEvent = currentEnd.isAtSameMomentAs(event.endDate);

      late final Edge eventEdge;
      if (isFirstEvent && !isLastEvent) {
        eventEdge = Edge.start;
      } else if (isLastEvent && !isFirstEvent) {
        eventEdge = Edge.end;
      } else if (isLastEvent && isFirstEvent) {
        eventEdge = Edge.single;
      } else {
        eventEdge = Edge.part;
      }

      dailyEvents.add(copyWith(
          startDate: currentStart, endDate: currentEnd, edge: eventEdge));

      isFirstEvent = false;

      // next day iteration
      currentStart = currentEnd.startOfNextDay;
    }

    return dailyEvents;
  }

  @override
  String toString() => title;

  VisibleDayEvent copyWith(
      {DateTime? startDate, DateTime? endDate, Edge? edge, Color? color}) {
    return VisibleDayEvent(
        title: title,
        id: id,
        edge: edge ?? this.edge,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        color: color ?? this.color);
  }
}

class EmptyEvent extends ViewEvent {
  const EmptyEvent({required super.startDate, required super.endDate});
}

enum Edge { start, single, end, part }

extension EdgeX on Edge {
  bool get isStart => this == Edge.start;
  bool get isSingle => this == Edge.single;
  bool get isEnd => this == Edge.end;
  bool get isPart => this == Edge.part;
}
