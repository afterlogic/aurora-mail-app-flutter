import 'dart:async';

import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:calendar_view/calendar_view.dart' as CV;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DayView extends StatefulWidget {
  const DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  final List<String> weekTitles = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  final CV.EventController _controller = CV.EventController();
  late final EventsBloc _bloc;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<EventsBloc>(context);
    _bloc.state.getEventsFromDay().forEach((e) {
      _controller.add(
        CV.CalendarEventData(
          title: e.title,
          date: (_bloc.state.selectedDate ?? _bloc.state.startIntervalDate).withoutTime,
          startTime: e.startDate,
          endTime: e.endDate,
          color: e.color,
        ),
      );
    });
    _subscription = _bloc.stream.listen(onStateChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  onStateChange(EventsState state) {
    final events = state.getEventsFromDay();
    final oldEvents = _controller.allEvents;
    if (oldEvents.isNotEmpty && events.isEmpty) {
      _controller.removeAll(oldEvents);
    }
    events.forEach((e) {
      _controller.add(
        CV.CalendarEventData(
          title: e.title,
          date: (state.selectedDate ?? state.startIntervalDate).withoutTime,
          // endDate: e.endDate.withoutTime,
          startTime: e.startDate,
          endTime: e.endDate,
          color: e.color,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Color(0xffdddddd), width: 1);

    return BlocBuilder<EventsBloc, EventsState>(
      bloc: _bloc,
      builder: (context, state) {
        return CV.DayView(
          showLiveTimeLineInAllDays: true,
          liveTimeIndicatorSettings: CV.LiveTimeIndicatorSettings(
              color: Theme.of(context).primaryColor, height: 3),
          initialDay: state.selectedDate ?? state.startIntervalDate,
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
          dateStringBuilder: (date, {secondaryDate}) =>
              DateFormat('y MMM d').format(date),
          fullDayEventBuilder: (events, date) {
            return Column(
              children: events
                  .map((e) => Container(
                        color: Colors.red,
                        height: 20,
                        width: double.infinity,
                        child: Text(e.title),
                      ))
                  .toList(),
            );
          },
          controller: _controller,
          onPageChange: (date, pageIndex) => _bloc.add(SelectDate(date)),
          onEventTap: (event, date) => print(event),
          onDateLongPress: (date) => print(date),
        );
      },
    );
  }
}
