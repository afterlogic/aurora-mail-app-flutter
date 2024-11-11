import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/activity/recurrence_mode.dart';
import 'package:aurora_mail/modules/calendar/ui/models/event.dart';
import 'package:aurora_mail/modules/calendar/ui/screens/event_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthEventMarker extends StatelessWidget {
  const MonthEventMarker(
      {super.key,
      required this.event,
      this.height = 15,
      this.fontSize = 10,
      this.addLeftBorder = false,
      this.forceTitleRender = false,
      this.isWeekAllDay = false,
      this.radius = 4.0,
      this.innerPaddingValue = 4.0,
      required this.currentDate,
      this.eventGap = 2});

  final ViewEvent? event;
  final bool addLeftBorder;
  final bool isWeekAllDay;
  final double eventGap;
  final double height;
  final DateTime currentDate;
  final bool forceTitleRender;
  final double fontSize;
  final double radius;
  final double innerPaddingValue;

  // double get emptyHeight => eventGap + height;

  @override
  Widget build(BuildContext context) {
    return event != null
        ? GestureDetector(
            onTap: () {
              BlocProvider.of<EventsBloc>(context).add(SelectEvent(event));
              Navigator.of(context).pushNamed(
                EventViewPage.name,
              );
            },
            child: Container(
              height: height,
              // It's needed to move left border one pixel left in all-day section
              transform: Matrix4.translationValues(-1, 0, 0),
              decoration: BoxDecoration(
                border: Border(
                  left: addLeftBorder && event?.isStartedToday(currentDate) == true
                      ? BorderSide(color: Theme.of(context).dividerColor)
                      : BorderSide.none
                )
              ),
              // child: Padding(
              padding: EdgeInsets.only(
                left: event?.isStartedToday(currentDate) == true
                    ? innerPaddingValue
                    : 0,
                right: event?.isEndedToday(currentDate) == true
                    ? innerPaddingValue
                    : 0
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: -0.5,
                    right: -0.5,
                    top: 0,
                    bottom: 0,
                    child: Container(
                        margin: isWeekAllDay
                            ? EdgeInsets.symmetric(vertical: eventGap / 2)
                            : EdgeInsets.only(bottom: eventGap),
                        padding: EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  event?.isStartedToday(currentDate) == true
                                      ? Radius.circular(radius)
                                      : Radius.zero,
                              bottomLeft:
                                  event?.isStartedToday(currentDate) == true
                                      ? Radius.circular(radius)
                                      : Radius.zero,
                              topRight:
                                  event?.isEndedToday(currentDate) == true
                                      ? Radius.circular(radius)
                                      : Radius.zero,
                              bottomRight:
                                  event?.isEndedToday(currentDate) == true
                                      ? Radius.circular(radius)
                                      : Radius.zero,
                            ),
                            color: event!.color),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              if (event?.isStartedToday(currentDate) ==
                                      true &&
                                  event?.recurrenceMode != null &&
                                  event?.recurrenceMode !=
                                      RecurrenceMode.never)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.repeat,
                                    size: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  forceTitleRender ||
                                          event?.isStartedToday(
                                                  currentDate) ==
                                              true
                                      ? event!.title
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              // ),
            ),
          )
        : EmptyMarker(
          height: height,
          addLeftBorder: addLeftBorder,
        );
  }
}

class EmptyMarker extends StatelessWidget {
  final bool addLeftBorder;
  final double height;
  const EmptyMarker({
    super.key,
    required this.addLeftBorder,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // It's needed to move left border one pixel left in all-day section
      transform: Matrix4.translationValues(-1, 0, 0),
      decoration: BoxDecoration(
          border: Border(
              left: addLeftBorder
                  ? BorderSide(color: Theme.of(context).dividerColor)
                  : BorderSide.none)),
      child: SizedBox(
        height: height,
        width: double.maxFinite,
      ),
    );
  }
}

class _EventText extends StatelessWidget {
  const _EventText({required this.edge, required this.title});

  final String title;
  final Edge edge;

  @override
  Widget build(BuildContext context) {
    return Text(
      edge.isSingle || edge.isStart ? title : "",
      style: TextStyle(fontSize: 10, color: Colors.white),
    );
  }
}
