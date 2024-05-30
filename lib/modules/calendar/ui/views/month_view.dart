import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/utils/calendar_month_builders_mixin.dart';
import 'package:aurora_mail/modules/calendar/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthView extends StatefulWidget {
  const MonthView({super.key});

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView>
    with TickerProviderStateMixin, CalendarMonthBuilders {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  late final AnimationController _eventListAnimationController;
  late final Animation _eventListAnimation;
  late final AnimationController _calendarAnimationController;
  late final Animation _calendarAnimation;

  final double _calendarDayTitleHeight = 36;

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
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    BlocProvider.of<EventsBloc>(context).add(SelectDate(selectedDay));
  }

  bool _showEventMarkerInShortMode(DateTime currentDate, bool show) {
    return _eventListAnimationController.value == 1.0 ? false : show;
  }

  Widget? _extendedModeBuilder(ctx, time, List<ViewEvent> events) =>
      extendedModeBuilder(events, _calendarDayTitleHeight);

  Widget _disabledDayBuilder(
          BuildContext context, DateTime currentDate, DateTime selectedDate) =>
      disabledDayBuilder(context, currentDate,
          cellHeight: _calendarDayTitleHeight);

  Widget _outsideDayBuilder(BuildContext context, DateTime currentDate,
          DateTime selectedDate, List<ViewEvent> events) =>
      outsideDayBuilder(context, currentDate,
          showEventMarker:
              _showEventMarkerInShortMode(currentDate, events.isNotEmpty),
          cellHeight: _calendarDayTitleHeight);

  Widget _defaultDayBuilder(BuildContext context, DateTime currentDate,
          DateTime selectedDate, List<ViewEvent> events) =>
      defaultDayBuilder(context, currentDate,
          showEventMarker:
              _showEventMarkerInShortMode(currentDate, events.isNotEmpty),
          cellHeight: _calendarDayTitleHeight);

  Widget _selectedDayBuilder(BuildContext context, DateTime currentDate,
          DateTime selectedDate, List<ViewEvent> events) =>
      selectedDayBuilder(context, currentDate,
          showEventMarker:
              _showEventMarkerInShortMode(currentDate, events.isNotEmpty),
          cellHeight: _calendarDayTitleHeight);

  Widget _todayDayBuilder(BuildContext context, DateTime currentDate,
          DateTime selectedDate, List<ViewEvent> events) =>
      todayDayBuilder(context, currentDate,
          showEventMarker:
              _showEventMarkerInShortMode(currentDate, events.isNotEmpty),
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
                    /// details.delta.dy > 1 - scroll up (finger from top to bottom)
                    /// _animationController.value == 1.0 - ListView collapsed
                    /// _calendarAnimationController.value == 1.0 - calendar shows 1 week
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
                  child: BlocBuilder<EventsBloc, EventsState>(
                    buildWhen: (prev, current) => prev != current,
                    builder: (context, state) {
                      return TableCalendar<ViewEvent>(
                        firstDay: DateTime(2010),
                        rowHeight: 10,
                        formatAnimationDuration:
                            const Duration(milliseconds: 200),
                        lastDay: DateTime(2040),
                        shouldFillViewport: true,
                        focusedDay:
                            state.selectedDate ?? state.startIntervalDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(state.selectedDate, day),
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: (date) {
                          return state.getEventsFromDay(date: date);
                        },
                        availableGestures: AvailableGestures.horizontalSwipe,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
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
                          defaultBuilder: (BuildContext context,
                                  DateTime currentDate,
                                  DateTime selectedDate) =>
                              _defaultDayBuilder(
                                  context,
                                  currentDate,
                                  selectedDate,
                                  state.getEventsFromDay(date: currentDate)),
                          todayBuilder: (BuildContext context,
                                  DateTime currentDate,
                                  DateTime selectedDate) =>
                              _todayDayBuilder(
                                  context,
                                  currentDate,
                                  selectedDate,
                                  state.getEventsFromDay(date: currentDate)),
                          selectedBuilder: (BuildContext context,
                                  DateTime currentDate,
                                  DateTime selectedDate) =>
                              _selectedDayBuilder(
                                  context,
                                  currentDate,
                                  selectedDate,
                                  state.getEventsFromDay(date: currentDate)),
                          outsideBuilder: (BuildContext context,
                                  DateTime currentDate,
                                  DateTime selectedDate) =>
                              _outsideDayBuilder(
                                  context,
                                  currentDate,
                                  selectedDate,
                                  state.getEventsFromDay(date: currentDate)),
                          disabledBuilder: _disabledDayBuilder,
                          markerBuilder:
                              _eventListAnimationController.value == 1.0
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
                          BlocProvider.of<EventsBloc>(context)
                              .add(SelectDate(focusedDay));
                        },
                      );
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
                  : _EventsInfoSection()),
        ),
      ],
    );
  }
}

class _EventsInfoSection extends StatelessWidget {
  const _EventsInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return Column(
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
              padding: const EdgeInsets.only(left: 24.0, bottom: 24, top: 20),
              child: Text(
                state.selectedDate == null
                    ? '${DateFormat('MMM d').format(state.startIntervalDate)} - ${DateFormat('MMM d').format(state.endIntervalDate)}'
                    : '${DateFormat('MMM d').format(state.selectedDate!)}',
                style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(150, 148, 148, 1)),
                overflow: TextOverflow.clip,
              ),
            ),
            if (state.selectedEvents != null)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: state.selectedEvents!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: EventCard(
                        event: state.selectedEvents![index],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
