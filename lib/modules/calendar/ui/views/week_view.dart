import 'dart:async';

import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:calendar_view/calendar_view.dart' as CV;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeekView extends StatefulWidget {
  const WeekView({super.key});

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  final List<String> weekTitles = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  final CV.EventController<WeekViewVisible> _controller =
      CV.EventController<WeekViewVisible>();
  late final EventsBloc _bloc;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<EventsBloc>(context);
    _onStateChange(_bloc.state);
    _subscription = _bloc.stream.listen(_onStateChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _cleanUpEvents(Map<DateTime, List<ViewEvent?>> week) {
    if (week.isEmpty) return;

    int maxLength = week.values.elementAt(0).length;

    for (int i = maxLength - 1; i >= 0; i--) {
      bool allNull = true;
      for (var day in week.values) {
        if (day.length > i && day[i] != null && day[i]?.allDay == true) {
          allNull = false;
          break;
        }
      }
      if (allNull) {
        for (var day in week.values) {
          if (day.length > i) {
            day.removeAt(i);
          }
        }
      }
    }
  }

  void _normalizeEventsLength(Map<DateTime, List> week) {
    int maxLength = 2;
    for (var day in week.values) {
      if (day.length > maxLength) {
        maxLength = day.length;
      }
    }

    for (var day in week.values) {
      while (day.length < maxLength) {
        day.add(null);
      }
    }
  }

  _onStateChange(EventsState state) {
    final events = Map.of(state.getEventsFromWeek());
    _normalizeEventsLength(events);
    _cleanUpEvents(events);
    final oldEvents = [..._controller.allEvents];
    _controller.removeAll(oldEvents);
    for (final date in events.keys) {
      final currentList = events[date]!;
      for (final e in currentList) {
        final isAllDay = e?.allDay != false;
        if (!isAllDay) {
          _controller.add(
            CV.CalendarEventData<WeekViewVisible>(
              event: e,
              title: e!.title,
              date: date,
              endDate: date,
              startTime: e.startDate.isAtSameDay(date)
                  ? e.startDate
                  : date.copyWith(hour: 0, minute: 1),
              endTime: e.endDate.isAtSameDay(date)
                  ? e.endDate
                  : date.copyWith(hour: 23, minute: 59),
              color: e.color,
            ),
          );

          /// necessary copy for all day section
          _controller.add(
            CV.CalendarEventData<WeekViewVisible>(
              event: EmptyViewEvent(),
              title: '',
              date: date.withoutTime,
              endDate: date.withoutTime,
              startTime: null,
              endTime: null,
              color: Colors.transparent,
            ),
          );
        } else {
          /// all day section
          _controller.add(
            CV.CalendarEventData<WeekViewVisible>(
              event: e == null ? EmptyViewEvent() : e,
              title: e == null ? '' : e.title,
              date: date.withoutTime,
              endDate: date.withoutTime,
              startTime: null,
              endTime: null,
              color: e == null ? Colors.transparent : e.color,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Color(0xffdddddd), width: 1);

    return BlocBuilder<EventsBloc, EventsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CV.WeekView<WeekViewVisible>(
                fullDayHeaderTitle: 'All day',
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.white,
                showLiveTimeLineInAllDays: true,
                liveTimeIndicatorSettings: CV.LiveTimeIndicatorSettings(
                    color: Theme.of(context).primaryColor, height: 3),
                initialDay: state.selectedDate,
                headerStyle: CV.HeaderStyle(
                  leftIcon: Icon(
                    Icons.chevron_left,
                    size: 30,
                  ),
                  rightIcon: Icon(
                    Icons.chevron_right,
                    size: 30,
                  ),
                  headerPadding: EdgeInsets.only(top: 12, bottom: 16),
                  headerTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  decoration: BoxDecoration(
                      color: null, border: Border(bottom: border)),
                ),
                headerStringBuilder: (date, {secondaryDate}) =>
                    DateFormat('yMMM').format(date),
                weekDayBuilder: (date) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                          left: date.weekday == DateTime.monday
                              ? border
                              : border.copyWith(color: Colors.transparent),
                          right: border),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weekTitles[date.weekday - 1],
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(date.day.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  );
                },
                fullDayEventBuilder:
                    (List<CV.CalendarEventData<Object?>> events,
                        DateTime date) {
                  return Column(
                    children: events.reversed
                        .map((e) => MonthEventMarker(
                              event:
                                  (e as CV.CalendarEventData<WeekViewVisible>)
                                          .event is ViewEvent
                                      ? e.event as ViewEvent
                                      : null,
                              implementBorder: true,
                              height: 19,
                              isWeekAllDay: true,
                              currentDate: date,
                            ))
                        .toList(),
                  );
                },
                controller: _controller,
                onPageChange: (date, pageIndex) => _bloc.add(SelectDate(date, isWeekChanged: true)),
                onEventTap: (List<CV.CalendarEventData<Object?>> events,
                    DateTime date) {
                  final event =
                      (events as List<CV.CalendarEventData<WeekViewVisible>>)
                          .firstOrNull;
                  if (event == null || event.event is EmptyViewEvent) return;
                  BlocProvider.of<EventsBloc>(context)
                      .add(SelectEvent(event.event as ViewEvent));
                  Navigator.of(context).pushNamed(
                    EventViewPage.name,
                  );
                },
                onDateLongPress: (date) => print(date),
              );
      },
    );
  }
}
