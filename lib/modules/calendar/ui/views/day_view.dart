import 'dart:async';

import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/week_event_marker.dart';
import 'package:calendar_view/calendar_view.dart' as CV;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';

class DayView extends StatefulWidget {
  const DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  final List<String> weekTitles = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  final CV.EventController<ViewEvent> _controller =
      CV.EventController<ViewEvent>();
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

  _onStateChange(EventsState state) {
    final events = state.getEventsForDay();
    final oldEvents = [..._controller.allEvents];
    _controller.removeAll(oldEvents);
    events.forEach((e) {
      _controller.add(
        CV.CalendarEventData(
          event: e,
          title: e.title,
          date: state.selectedDate.withoutTime,
          endDate: e.endDate.withoutTime,
          startTime: e.allDay != false ? null : e.startDate,
          endTime: e.allDay != false ? null : e.endDate,
          color: e.color,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Theme.of(context).dividerColor, width: 1);
    final settingsState = BlocProvider.of<SettingsBloc>(context).state;

    return BlocBuilder<EventsBloc, EventsState>(
      bloc: _bloc,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CV.DayView<ViewEvent>(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          showLiveTimeLineInAllDays: true,
          fullDayTitle: Container(
            decoration: BoxDecoration( border: Border(bottom: border)),
            child: Center(
              child: Text(
                'All day',
              ),
            ),
            // constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
            height: 40,
          ),
          liveTimeIndicatorSettings: CV.LiveTimeIndicatorSettings(
              color: Theme.of(context).primaryColor, height: 2),
          initialDay: state.selectedDate,
          keepScrollOffset: true,
          scrollOffset: 480.0, // 8h * 60min * heightPerMinute
          heightPerMinute: 1,
          showHalfHours: false,
          headerStyle: CV.HeaderStyle( // current day switcher
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
          hourIndicatorSettings: CV.HourIndicatorSettings( // Grid lines color
              color: Theme.of(context).dividerColor,
            offset: 5, // offset between hour labels and the grid
          ),
          dateStringBuilder: (date, {secondaryDate}) =>
              DateFormat('y MMM d').format(date),
          timeStringBuilder: (date, {secondaryDate}) {
            String sTimeFormat = ((settingsState as SettingsLoaded).is24 ? 'HH:mm' : 'h a');
            return DateFormat(sTimeFormat).format(date);
          },
          eventTileBuilder: (
              DateTime date,
              List<CV.CalendarEventData<Object?>> events,
              Rect boundary,
              DateTime startDuration,
              DateTime endDuration) {
            return WeekEventMarker(
              event: (events as List<CV.CalendarEventData<ViewEvent?>>)[0].event,
              currentDate: date,
            );
          },
          fullDayEventBuilder:
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 40,
                  maxHeight: 100
              ),
              child: Container(
                padding:  EdgeInsets.only(top: 1),
                transform: Matrix4.translationValues(-0.5, 0, 0),
                decoration: BoxDecoration( border: Border(left: border, bottom: border)),
                child: ListView.builder(
                  itemCount: events.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      final event = (events as List<CV.CalendarEventData<ViewEvent?>>)[index];
                      BlocProvider.of<EventsBloc>(context)
                          .add(SelectEvent(event.event));
                      Navigator.of(context).pushNamed(
                        EventViewPage.name,
                      );
                    },
                    child: MonthEventMarker(
                      event: (events as List<CV.CalendarEventData<ViewEvent?>>)[index].event,
                      currentDate: date,
                      addLeftBorder: false,
                      forceTitleRender: true,
                      eventGap: 2,
                      radius: 4,
                      height: 18,
                      fontSize: 12,
                      innerPaddingValue: 2,
                    ),
                  ),
                ),
              ),
            );
          },
          controller: _controller,
          onPageChange: (date, pageIndex) => _bloc.add(SelectDate(date, isDayMode: true)),
          onEventTap:
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
            final event = (events as List<CV.CalendarEventData<ViewEvent?>>)
                .firstOrNull;
            if (event == null) return;
            BlocProvider.of<EventsBloc>(context)
                .add(SelectEvent(event.event));
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
