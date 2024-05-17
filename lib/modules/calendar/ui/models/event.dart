import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';

abstract class CalendarEvent {
  const CalendarEvent();
}

class ViewEvent extends CalendarEvent {
  final String title;
  final String id;
  final Edge edge;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDay;

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

  const ViewEvent(
      {this.edge = Edge.single,
      required this.title,
      required this.id,
      required this.startDate,
      required this.endDate,
      this.isAllDay = false});

  @override
  String toString() => title;
}

class EmptyEvent extends CalendarEvent {
  const EmptyEvent();
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

enum Edge { start, single, end, part }

extension EdgeX on Edge {
  bool get isStart => this == Edge.start;
  bool get isSingle => this == Edge.single;
  bool get isEnd => this == Edge.end;
  bool get isPart => this == Edge.part;
}
