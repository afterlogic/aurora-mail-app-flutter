import 'dart:ui';

import 'package:aurora_mail/modules/calendar/calendar_domain/models/event.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/event_base.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';

class ViewEvent extends Event {
  final DateTime startDate;
  final DateTime endDate;
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
          recurrenceId: e.recurrenceId!,
          uid: e.uid,
          userLocalId: e.userLocalId,
          updateStatus: e.updateStatus,
          synced: e.synced,
          onceLoaded: e.onceLoaded,
          organizer: e.organizer,
          appointment: e.appointment,
          appointmentAccess: e.appointmentAccess,
          subject: e.subject,
          description: e.description,
          location: e.location,
          startTS: e.startTS,
          endTS: e.endTS,
          allDay: e.allDay,
          owner: e.owner,
          modified: e.modified,
          lastModified: e.lastModified,
          rrule: e.rrule,
          status: e.status,
          withDate: e.withDate,
          isPrivate: e.isPrivate);
    } catch (e, s) {
      return null;
    }
  }

  const ViewEvent(
      {required this.startDate,
      required this.endDate,
      required this.title,
      required this.color,
      required super.organizer,
      required super.appointment,
      required super.appointmentAccess,
      required super.calendarId,
      required super.userLocalId,
      required super.uid,
      required super.subject,
      required super.description,
      required super.location,
      required super.startTS,
      required super.endTS,
      required super.allDay,
      required super.owner,
      required super.modified,
      required super.recurrenceId,
      required super.lastModified,
      required super.rrule,
      required super.status,
      required super.withDate,
      required super.isPrivate,
      required super.updateStatus,
      required super.synced,
      required super.onceLoaded});

  @override
  ViewEvent copyWith({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? organizer,
    bool? appointment,
    int? appointmentAccess,
    String? calendarId,
    int? userLocalId,
    String? uid,
    String? subject,
    String? description,
    String? location,
    DateTime? startTS,
    DateTime? endTS,
    bool? allDay,
    String? owner,
    bool? modified,
    int? recurrenceId,
    int? lastModified,
    Rrule? rrule,
    bool? status,
    bool? withDate,
    bool? isPrivate,
    UpdateStatus? updateStatus,
    bool? synced,
    bool? onceLoaded,
  }) =>
      ViewEvent(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        organizer: organizer ?? this.organizer,
        appointment: appointment ?? this.appointment,
        appointmentAccess: appointmentAccess ?? this.appointmentAccess,
        calendarId: calendarId ?? this.calendarId,
        userLocalId: userLocalId ?? this.userLocalId,
        uid: uid ?? this.uid,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        location: location ?? this.location,
        startTS: startTS ?? this.startTS,
        endTS: endTS ?? this.endTS,
        allDay: allDay ?? this.allDay,
        owner: owner ?? this.owner,
        modified: modified ?? this.modified,
        recurrenceId: recurrenceId ?? this.recurrenceId,
        lastModified: lastModified ?? this.lastModified,
        rrule: rrule ?? this.rrule,
        status: status ?? this.status,
        withDate: withDate ?? this.withDate,
        isPrivate: isPrivate ?? this.isPrivate,
        updateStatus: updateStatus ?? this.updateStatus,
        synced: synced ?? this.synced,
        onceLoaded: onceLoaded ?? this.onceLoaded,
        title: title ?? this.title,
        color: color,
      );

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

      dailyEvents.add(copyWith(
          startDate: currentStart, endDate: currentEnd));
      // next day iteration
      currentStart = currentEnd.startOfNextDay;
    }

    return dailyEvents;
  }

  ViewEvent _normalise() {
    if (!startDate.startOfNextDay.isAtSameMomentAs(endDate)) {
      return this;
    }
    return copyWith(endDate: endDate.subtract(Duration(seconds: 1)));
  }
}

class ExtendedMonthEvent extends ViewEvent {
  bool overflow;
  int? slotIndex;

  factory ExtendedMonthEvent.fromViewEvent(
    ViewEvent e,
  ) =>
      ExtendedMonthEvent(
          startDate: e.startTS!,
          endDate: e.endTS!,
          calendarId: e.calendarId,
          title: e.subject!,
          color: e.color,
          recurrenceId: e.recurrenceId!,
          uid: e.uid,
          userLocalId: e.userLocalId,
          updateStatus: e.updateStatus,
          synced: e.synced,
          onceLoaded: e.onceLoaded,
          organizer: e.organizer,
          appointment: e.appointment,
          appointmentAccess: e.appointmentAccess,
          subject: e.subject,
          description: e.description,
          location: e.location,
          startTS: e.startTS,
          endTS: e.endTS,
          allDay: e.allDay,
          owner: e.owner,
          modified: e.modified,
          lastModified: e.lastModified,
          rrule: e.rrule,
          status: e.status,
          withDate: e.withDate,
          isPrivate: e.isPrivate);

  ExtendedMonthEvent(
      {this.overflow = false,
      this.slotIndex,
      required super.startDate,
      required super.endDate,
      required super.title,
      required super.color,
      required super.organizer,
      required super.appointment,
      required super.appointmentAccess,
      required super.calendarId,
      required super.userLocalId,
      required super.uid,
      required super.subject,
      required super.description,
      required super.location,
      required super.startTS,
      required super.endTS,
      required super.allDay,
      required super.owner,
      required super.modified,
      required super.recurrenceId,
      required super.lastModified,
      required super.rrule,
      required super.status,
      required super.withDate,
      required super.isPrivate,
      required super.updateStatus,
      required super.synced,
      required super.onceLoaded});
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
