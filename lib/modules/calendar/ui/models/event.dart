import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';

abstract class CalendarEvent {
  final DateTime startDate;
  final DateTime endDate;
  const CalendarEvent({required this.startDate, required this.endDate});
}

class ViewEvent extends CalendarEvent {
  final String title;
  final String id;
  final Edge edge;
  final bool isAllDay;

  const ViewEvent(
      {this.edge = Edge.single,
      required this.title,
      required this.id,
      required super.startDate,
      required super.endDate,
      this.isAllDay = false});

  static ViewEvent? tryFromEvent(Event model) {
    try {
      return ViewEvent(
          title: model.subject!,
          id: model.uid,
          startDate: model.startTS!,
          endDate: model.endTS!);
    } catch (e) {
      return null;
    }
  }

  ViewEvent _normalise(){
    if(!startDate.startOfNextDay.isAtSameMomentAs(endDate)){
      return this;
    }
    return copyWith(endDate: endDate.subtract(Duration(seconds: 1)));
  }

  List<ViewEvent> get splitIntoDailyEvents {
    List<ViewEvent> dailyEvents = [];
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

  // late final Edge eventEdge;
  // if (isFirstEvent) {
  // eventEdge = Edge.start;
  // } else if (isLastEvent) {
  // eventEdge = Edge.end;
  // } else {
  // eventEdge = Edge.part;
  // }
  //
  // dailyEvents.add(copyWith(
  // startDate: currentStart, endDate: currentEnd, edge: eventEdge));

  @override
  String toString() => title;

  ViewEvent copyWith({DateTime? startDate, DateTime? endDate, Edge? edge}) {
    return ViewEvent(
        title: title,
        id: id,
        edge: edge ?? this.edge,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }
}

class EmptyEvent extends CalendarEvent {
  const EmptyEvent({required super.startDate, required super.endDate});
}

enum Edge { start, single, end, part }

extension EdgeX on Edge {
  bool get isStart => this == Edge.start;
  bool get isSingle => this == Edge.single;
  bool get isEnd => this == Edge.end;
  bool get isPart => this == Edge.part;
}
