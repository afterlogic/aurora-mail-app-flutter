import 'dart:ui';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';

class ViewEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String id;
  final String calendarId;
  final Color color;
  final String title;

  Duration get duration => endDate.difference(startDate);

  bool isStartedToday(DateTime currentDate) =>
      startDate.withoutTime.isAtSameMomentAs(currentDate.withoutTime);

  bool isEndedToday(DateTime currentDate) =>
      endDate.withoutTime.isAtSameMomentAs(currentDate.withoutTime);

  static ViewEvent? tryFromEvent(Event e, {required Color color}) {
    try {
      return ViewEvent(
          startDate: e.startTS!,
          endDate: e.endTS!,
          calendarId: e.calendarId,
          title: e.subject!,
          color: color,
          id: e.uid);
    } catch (e, s) {
      return null;
    }
  }

  const ViewEvent(
      {required this.startDate,
      required this.endDate,
      required this.calendarId,
      required this.color,
      required this.id,
      required this.title});

  ViewEvent copyWith({DateTime? startDate, DateTime? endDate}) => ViewEvent(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      color: color,
      calendarId: calendarId,
      id: id,
      title: title);
}

class ExtendedMonthEvent extends ViewEvent {
  bool overflow;
  int? slotIndex;

  factory ExtendedMonthEvent.fromViewEvent(
    ViewEvent e,
  ) =>
      ExtendedMonthEvent(
          startDate: e.startDate,
          endDate: e.endDate,
          title: e.title,
          calendarId: e.calendarId,
          color: e.color,
          id: e.id);

  ExtendedMonthEvent({
    this.overflow = false,
    this.slotIndex,
    required super.calendarId,
    required super.startDate,
    required super.endDate,
    required super.title,
    required super.color,
    required super.id,
  });
}

// class VisibleDayEvent extends ViewEvent {
//   final String title;
//   final String id;
//   final Edge edge;
//   final bool isAllDay;
//   final Color color;
//
//   VisibleDayEvent(
//       {this.edge = Edge.single,
//       required this.title,
//       required this.id,
//       required super.startDate,
//       required super.endDate,
//       required super.color,
//       this.isAllDay = false});
//
//   static VisibleDayEvent? tryFromEvent(Event model, {required Color color}) {
//     try {
//       return VisibleDayEvent(
//           title: model.subject!,
//           id: model.uid,
//           startDate: model.startTS!,
//           endDate: model.endTS!,
//           color: color);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   VisibleDayEvent _normalise() {
//     if (!startDate.startOfNextDay.isAtSameMomentAs(endDate)) {
//       return this;
//     }
//     return copyWith(endDate: endDate.subtract(Duration(seconds: 1)));
//   }
//
//   List<VisibleDayEvent> get splitIntoDailyEvents {
//     List<VisibleDayEvent> dailyEvents = [];
//     final event = _normalise();
//
//     DateTime currentStart = event.startDate;
//     DateTime currentEnd;
//
//     // if event starts and ends at same day
//     if ((event.startDate.year == event.endDate.year &&
//         event.startDate.month == event.endDate.month &&
//         event.startDate.day == event.endDate.day)) {
//       dailyEvents.add(event);
//       return dailyEvents;
//     }
//
//     bool isFirstEvent = true;
//
//     while (currentStart.isBefore(event.endDate)) {
//       // set end of day OR event
//       currentEnd = DateTime(
//         currentStart.year,
//         currentStart.month,
//         currentStart.day,
//         23,
//         59,
//         59,
//       );
//
//       if (currentEnd.isAfter(event.endDate) ||
//           currentEnd.isAtSameMomentAs(event.endDate)) {
//         currentEnd = event.endDate;
//       }
//
//       bool isLastEvent = currentEnd.isAtSameMomentAs(event.endDate);
//
//       late final Edge eventEdge;
//       if (isFirstEvent && !isLastEvent) {
//         eventEdge = Edge.start;
//       } else if (isLastEvent && !isFirstEvent) {
//         eventEdge = Edge.end;
//       } else if (isLastEvent && isFirstEvent) {
//         eventEdge = Edge.single;
//       } else {
//         eventEdge = Edge.part;
//       }
//
//       dailyEvents.add(copyWith(
//           startDate: currentStart, endDate: currentEnd, edge: eventEdge));
//
//       isFirstEvent = false;
//
//       // next day iteration
//       currentStart = currentEnd.startOfNextDay;
//     }
//
//     return dailyEvents;
//   }
//
//   @override
//   String toString() => title;
//
//   VisibleDayEvent copyWith(
//       {DateTime? startDate, DateTime? endDate, Edge? edge, Color? color}) {
//     return VisibleDayEvent(
//         title: title,
//         id: id,
//         edge: edge ?? this.edge,
//         startDate: startDate ?? this.startDate,
//         endDate: endDate ?? this.endDate,
//         color: color ?? this.color);
//   }
// }

enum Edge { start, single, end, part }

extension EdgeX on Edge {
  bool get isStart => this == Edge.start;
  bool get isSingle => this == Edge.single;
  bool get isEnd => this == Edge.end;
  bool get isPart => this == Edge.part;
}
