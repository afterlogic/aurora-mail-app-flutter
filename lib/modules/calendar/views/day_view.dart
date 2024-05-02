import 'package:calendar_view/calendar_view.dart' as CV;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayView extends StatefulWidget {
  const DayView({super.key});

  @override
  State<DayView> createState() => _DayViewState();
}

// CalendarEventData(
// title: e["summary"].toString().substring(2),
// date: DateTime.parse(e["dtstart"]["dt"],).withoutTime,
// startTime: DateTime.parse(e["dtstart"]["dt"],),
// endTime: DateTime.parse(e["dtstart"]["dt"],),
// endDate: DateTime.parse(e["dtend"]["dt"],).withoutTime,
// )

class _DayViewState extends State<DayView> {
  final List<String> weekTitles = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  late final CV.EventController _controller;
  final DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller = CV.EventController();
    final events = [
      CV.CalendarEventData(
        title: 'test',
        date: _currentDate.copyWith(day: _currentDate.day - 1).withoutTime,
        endDate: _currentDate.copyWith(day: _currentDate.day + 1).withoutTime,
        // startTime: _currentDate.copyWith(
        //   day: _currentDate.day - 1,
        // ),
        // endTime: _currentDate.copyWith(
        //     day: _currentDate.day + 1, hour: _currentDate.hour + 2),
      ),
      CV.CalendarEventData(
        title: 'test2',
        date: _currentDate.copyWith(day: _currentDate.day).withoutTime,
        endDate: _currentDate.copyWith(day: _currentDate.day + 1).withoutTime,
        // startTime: _currentDate.copyWith(day: _currentDate.day),
        // endTime: _currentDate.copyWith(
        //     day: _currentDate.day + 1, hour: _currentDate.hour + 2),
      ),
      CV.CalendarEventData(
        title: 'test3',
        date: _currentDate.copyWith(day: _currentDate.day).withoutTime,
        endDate: _currentDate.copyWith(day: _currentDate.day + 2).withoutTime,
        // startTime: _currentDate.copyWith(day: _currentDate.day),
        // endTime: _currentDate.copyWith(
        //     day: _currentDate.day + 2, hour: _currentDate.hour + 2),
      ),
      CV.CalendarEventData(
        title: 'test4',
        date: _currentDate.copyWith(day: _currentDate.day).withoutTime,
        // endDate: _currentDate.copyWith(day: _currentDate.day + 3).withoutTime,
        startTime: _currentDate.copyWith(
            day: _currentDate.day, hour: _currentDate.hour - 2),
        endTime: _currentDate.copyWith(
            day: _currentDate.day + 3, hour: _currentDate.hour + 2),
      ),
    ];

    events.forEach((element) {
      _controller.add(element);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Color(0xffdddddd), width: 1);

    return CV.DayView(
      showLiveTimeLineInAllDays: true,
      liveTimeIndicatorSettings: CV.LiveTimeIndicatorSettings(color: Theme.of(context).primaryColor, height: 3),

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
        headerTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        decoration: BoxDecoration(color: null, border: Border(bottom: border)),
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
      onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
      onEventTap: (event, date) => print(event),
      onDateLongPress: (date) => print(date),
    );
  }
}
