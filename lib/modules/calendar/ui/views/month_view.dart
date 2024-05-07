import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_month_builders_mixin.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthView extends StatefulWidget {
  const MonthView({super.key});

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView>
    with TickerProviderStateMixin, CalendarMonthBuilders {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late final AnimationController _eventListAnimationController;
  late final Animation _eventListAnimation;
  late final AnimationController _calendarAnimationController;
  late final Animation _calendarAnimation;

  final double _calendarDayTitleHeight = 36;

  final kEvents = <DateTime, List<CalendarEvent>>{}..addAll({
      DateTime.utc(kToday.year, kToday.month, kToday.day - 1): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.start),
        Event(
            title: 'test4',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 1,
            edge: Edge.start),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.part),
        Event(
            title: 'test4',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 1,
            edge: Edge.end),
        const EmptyEvent(),
      ],
      DateTime.utc(kToday.year, kToday.month, kToday.day + 1): [
        Event(
            title: 'test2',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 2,
            edge: Edge.end),
        const EmptyEvent(),
        Event(
            title: 'test3',
            startDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            endDate: DateTime.utc(kToday.year, kToday.month, kToday.day - 1),
            id: 3,
            edge: Edge.single),
      ]
    });

  @override
  initState() {
    super.initState();
    _eventListAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _eventListAnimation =
        IntTween(begin: 100, end: 0).animate(_eventListAnimationController);
    _eventListAnimation.addListener(() => setState(() {}));
    _calendarAnimationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _calendarAnimation =
        IntTween(begin: 140, end: 50).animate(_calendarAnimationController);
    _calendarAnimation.addListener(() {
      print(_calendarAnimationController.value);

      setState(() {});
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
        kEvents.entries.map((e) => e.value).expand((e) => e).toList());
  }

  @override
  dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  bool _showEventMarkerInShortMode(DateTime currentDate) {
    return _eventListAnimationController.value == 1.0
        ? false
        : kEvents[currentDate]?.isNotEmpty ?? false;
  }

  Widget? _extendedModeBuilder(ctx, time, List<CalendarEvent> events) =>
      extendedModeBuilder(events, _calendarDayTitleHeight);

  Widget _disabledDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      disabledDayBuilder(context, currentDate,
          cellHeight: _calendarDayTitleHeight);

  Widget _outsideDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      outsideDayBuilder(context, currentDate,
          showEventMarker: _showEventMarkerInShortMode(currentDate),
          cellHeight: _calendarDayTitleHeight);

  Widget _defaultDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      defaultDayBuilder(context, currentDate,
          showEventMarker: _showEventMarkerInShortMode(currentDate),
          cellHeight: _calendarDayTitleHeight);

  Widget _selectedDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      selectedDayBuilder(context, currentDate,
          showEventMarker: _showEventMarkerInShortMode(currentDate),
          cellHeight: _calendarDayTitleHeight);

  Widget _todayDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      todayDayBuilder(context, currentDate,
          showEventMarker: _showEventMarkerInShortMode(currentDate),
          cellHeight: _calendarDayTitleHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: _calendarAnimation.value as int,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // details.delta.dy > 1 - scroll up (finger from top to bottom)
                    // _animationController.value == 1.0 - ListView collapsed
                    // _calendarAnimationController.value == 1.0 - calendar shows 1 week
                    if (details.delta.dy > 1 &&
                        _calendarAnimationController.value == 1.0 &&
                        _eventListAnimationController.value == 0.0) {
                      _calendarAnimationController.reverse().then((_) {
                        _calendarFormat = CalendarFormat.month;
                        setState(() {});
                      });
                    }
                    if (details.delta.dy < -1 &&
                        _calendarAnimationController.value == 0.0 &&
                        _eventListAnimationController.value == 0.0) {
                      _calendarAnimationController.forward().then((_) {
                        _calendarFormat = CalendarFormat.week;
                        setState(() {});
                      });
                    }

                    if (details.delta.dy > 1 &&
                        _eventListAnimationController.value == 0.0 &&
                        _calendarAnimationController.value == 0.0) {
                      _eventListAnimationController.forward();
                    }
                    if (details.delta.dy < -1 &&
                        _eventListAnimationController.value == 1.0 &&
                        _calendarAnimationController.value == 0.0) {
                      _eventListAnimationController.reverse();
                    }
                  },
                  child: TableCalendar<CalendarEvent>(
                    firstDay: kFirstDay,
                    rowHeight: 10,
                    formatAnimationDuration: const Duration(milliseconds: 200),
                    lastDay: kLastDay,
                    shouldFillViewport: true,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        weekendStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: _defaultDayBuilder,
                      todayBuilder: _todayDayBuilder,
                      selectedBuilder: _selectedDayBuilder,
                      outsideBuilder: _outsideDayBuilder,
                      disabledBuilder: _disabledDayBuilder,
                      markerBuilder: _eventListAnimationController.value == 1.0
                          ? _extendedModeBuilder
                          : (_, __, ___) => SizedBox.shrink(),
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: const CalendarStyle(),
                    onDaySelected: _onDaySelected,
                    daysOfWeekHeight: 40,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _eventListAnimationController.value == 1.0
                    ? const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color.fromRGBO(217, 217, 217, 1),
                          size: 18,
                        ),
                      )
                    : const Icon(
                        Icons.minimize_outlined,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        Expanded(
          flex: _eventListAnimation.value as int,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: _eventListAnimation.value == 0.0
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(246, 246, 246, 1),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, bottom: 24, top: 20),
                        child: Text(
                          'Placeholder',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(150, 148, 148, 1)),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder<List<CalendarEvent>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return EventCard(
                                  event: value[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
