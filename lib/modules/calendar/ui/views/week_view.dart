import 'dart:async';

import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/month_event_marker.dart';
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
  final CV.EventController<ViewEvent?> _controller =
      CV.EventController<ViewEvent?>();
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
    final events = state.getEventsFromWeek();
    final oldEvents = [..._controller.allEvents];
    _controller.removeAll(oldEvents);
    events.forEach((key, value) {
      value.forEach((e) {
        _controller.add(
          CV.CalendarEventData<ViewEvent?>(
            event: e,
            title: e == null ? '' : e.title,
            date: e?.allDay != false ? key.withoutTime : e!.startDate.withoutTime,
            endDate: e?.allDay != false ? key.withoutTime : e!.endDate.withoutTime,
            startTime: e?.allDay != false ? null : e!.startDate,
            endTime: e?.allDay != false ? null : e!.endDate,
            color: e == null ? Colors.transparent : e.color,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Color(0xffdddddd), width: 1);

    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return CV.WeekView<ViewEvent?>(
          fullDayHeaderTitle: 'ALL DAY',
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
            decoration:
                BoxDecoration(color: null, border: Border(bottom: border)),
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
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
            return Column(
              children: events
                  .map((e) => MonthEventMarker(
                        event: (e as CV.CalendarEventData<ViewEvent?>).event,
                        currentDate: date,
                      ))
                  .toList(),
            );
          },
          controller: _controller,
          onPageChange: (date, pageIndex) => _bloc.add(SelectDate(date)),
          onEventTap:
              (List<CV.CalendarEventData<Object?>> events, DateTime date) {
            final event =
                (events as List<CV.CalendarEventData<ViewEvent?>>).firstOrNull;
            if (event == null) return;
            BlocProvider.of<EventsBloc>(context).add(SelectEvent(event.event));
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
