abstract class CalendarEvent {
  const CalendarEvent();
}

class Event extends CalendarEvent{
  final String title;
  final int? id;
  final Edge edge;

  const Event(this.title, this.id, {this.edge = Edge.single});

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

enum Edge {
  start,
  single,
  end,
  part
}

extension EdgeX on Edge {
  bool get isStart => this == Edge.start;
  bool get isSingle => this == Edge.single;
  bool get isEnd => this == Edge.end;
  bool get isPart => this == Edge.part;
}