import 'dart:async';

import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/week_event_marker.dart';
import 'package:aurora_mail/modules/calendar/utils/date_time_ext.dart';
import 'package:aurora_mail/modules/calendar/utils/week_mode_utils.dart';
import 'package:calendar_view/calendar_view.dart' as CV;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';

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

  CV.WeekDays _getWeekStartDay(int dayCode) {
    switch (dayCode) {
      case 1:
        return CV.WeekDays.monday;
      case 2:
        return CV.WeekDays.tuesday;
      case 3:
        return CV.WeekDays.wednesday;
      case 4:
        return CV.WeekDays.thursday;
      case 5:
        return CV.WeekDays.friday;
      case 6:
        return CV.WeekDays.saturday;
      case 7:
        return CV.WeekDays.sunday;
      default:
        return CV.WeekDays.monday;
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Theme.of(context).dividerColor, width: 1);
    final settingsState = BlocProvider.of<SettingsBloc>(context).state;

    return BlocBuilder<EventsBloc, EventsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CV.WeekView<WeekViewVisible>(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          startDay: _getWeekStartDay(state.firstDayInWeek),
          weekNumberBuilder: (date) => Container(
            decoration: BoxDecoration(
              border: Border(
                right: border,
              ),
            ),
            child: Center(
              child: Text(
                date.weekOfYear.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)
              ),
            ),
          ),
          fullDayHeaderTitle: 'All day',
          showLiveTimeLineInAllDays: true,
          liveTimeIndicatorSettings: CV.LiveTimeIndicatorSettings(
              color: Theme.of(context).primaryColor, height: 2),
          initialDay: state.selectedDate,
          keepScrollOffset: true,
          showVerticalLines: true,
          scrollOffset: 480.0,
          heightPerMinute: 1,
          showHalfHours: false,
          headerStyle: CV.HeaderStyle( // current week switcher
            leftIcon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            rightIcon: Icon(
              Icons.chevron_right,
              size: 30,
            ),
            headerPadding: EdgeInsets.only(top: 12, bottom: 16),
            headerTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            decoration: BoxDecoration(color: null, border: Border(bottom: border)),
          ),
          headerStringBuilder: (date, {secondaryDate}) =>
              DateFormat('yMMM').format(date),
          timeLineStringBuilder: (date, {secondaryDate}) {
            String sTimeFormat = ((settingsState as SettingsLoaded).is24 ? 'HH:mm' : 'h a');
            return DateFormat(sTimeFormat).format(date);
          },
          weekDayBuilder: (date) { // week days header
            return Container(
              decoration: BoxDecoration(
                border: Border(
                    right: border,
                  ),
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
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
            return Column(
              children: events.reversed
                  .map((e) => MonthEventMarker(
                      event: (e as CV.CalendarEventData<WeekViewVisible>).event is ViewEvent
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
          eventTileBuilder: (
              DateTime date,
              List<CV.CalendarEventData<Object?>> events,
              Rect boundary,
              DateTime startDuration,
              DateTime endDuration) {
            return WeekEventMarker(
              event: (events as List<CV.CalendarEventData<WeekViewVisible>>)[0].event as ViewEvent,
              currentDate: date,
              forceTitleRender: true,
              eventGap: 8,
              radius: 10,
              fontSize: 16,
              innerPaddingValue: 0,
            );
          },
          controller: _controller,
          onPageChange: (date, pageIndex) =>
              _bloc.add(SelectDate(date, isWeekMode: true)),
          onEventTap:
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
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

  _onStateChange(EventsState state) {
    final sourceEvents = Map.of(state.getEventsFromWeek());
    // TODO: remove this step after fixing problem with adding unnecessary null values to collection.
    final events = deepCloneAndSeparateEvents(sourceEvents);

    // we need to pad days with en empty values to stretch the cells in all-day area
    final allDayEvents = events['allDayEvents'];
    if (allDayEvents != null) {
      normalizeAndCleanUpEvents(allDayEvents);
    }

    final oldEvents = [..._controller.allEvents];
    _controller.removeAll(oldEvents);

    // adding all day events to the grid
    events['allDayEvents']?.forEach((date, dayEvents) {
      dayEvents.forEach((event) {
        _controller.add(
          CV.CalendarEventData<WeekViewVisible>(
            event: event == null ? EmptyViewEvent() : event,
            title: event == null ? '' : event.title,
            date: date.withoutTime,
            endDate: date.withoutTime,
            startTime: null,
            endTime: null,
            color: event == null ? Colors.transparent : event.color,
          ),
        );
      });
    });

    // adding non-all-day events to the grid
    events['events']?.forEach((date, dayEvents) {
      dayEvents.forEach((event) {
        _controller.add(
          CV.CalendarEventData<WeekViewVisible>(
            event: event,
            title: event!.title,
            date: date,
            endDate: date,
            startTime: event.startDate.isAtSameDay(date)
              ? event.startDate
              : date.copyWith(hour: 0, minute: 1),
            endTime: event.endDate.isAtSameDay(date)
              ? event.endDate
              : date.copyWith(hour: 23, minute: 59),
            color: event.color,
          ),
        );
      });
    });
  }
}
