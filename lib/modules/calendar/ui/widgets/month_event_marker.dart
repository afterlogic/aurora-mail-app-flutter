import 'package:aurora_mail/modules/calendar/blocs/events/events_bloc.dart';
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
      this.implementLeftBorder = false,
      this.implementBorder = false,
      this.forceTitleRender = false,
      this.radius = 4.0,
      this.innerPaddingValue = 4.0,
      required this.currentDate,
      this.eventGap = 2});

  final ViewEvent? event;
  final bool implementLeftBorder;
  final bool implementBorder;
  final double eventGap;
  final double height;
  final DateTime currentDate;
  final bool forceTitleRender;
  final double fontSize;
  final double radius;
  final double innerPaddingValue;

  double get emptyHeight => eventGap + height;

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
              decoration: BoxDecoration(
                  border: Border(
                      right: implementBorder && event?.isEndedToday(currentDate) == true ? BorderSide(color: Color(0xffdddddd)) : BorderSide.none,
                      left: implementLeftBorder && implementBorder && event?.isStartedToday(currentDate) == true
                          ? BorderSide(color: Color(0xffdddddd))
                          : BorderSide.none)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: event?.isStartedToday(currentDate) == true
                        ? innerPaddingValue
                        : 0,
                    right: event?.isEndedToday(currentDate) == true
                        ? innerPaddingValue
                        : 0),
                child: Container(
                    margin: EdgeInsets.only(bottom: eventGap),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: event?.isStartedToday(currentDate) == true
                              ? Radius.circular(radius)
                              : Radius.zero,
                          bottomLeft: event?.isStartedToday(currentDate) == true
                              ? Radius.circular(radius)
                              : Radius.zero,
                          topRight: event?.isEndedToday(currentDate) == true
                              ? Radius.circular(radius)
                              : Radius.zero,
                          bottomRight: event?.isEndedToday(currentDate) == true
                              ? Radius.circular(radius)
                              : Radius.zero,
                        ),
                        color: event!.color),
                    width: 60,
                    height: height,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        forceTitleRender ||
                                event?.isStartedToday(currentDate) == true
                            ? event!.title
                            : '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: fontSize, color: Colors.white),
                      ),
                    )),
              ),
            ),
          )
        : EmptyMarker(h: emptyHeight, w: 60, implementLeftBorder: implementLeftBorder, implementBorder: implementBorder,);
  }

  BorderRadius? _calculateBorderRadius(Edge edge) {
    final radius = 4.0;
    switch (edge) {
      case Edge.start:
        return BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius));
      case Edge.single:
        return BorderRadius.all(Radius.circular(radius));
      case Edge.end:
        return BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius));
      case Edge.part:
        return null;
    }
  }
}

class EmptyMarker extends StatelessWidget {
  final bool implementLeftBorder;
  final bool implementBorder;
  final double h;
  final double w;
  const EmptyMarker(
      {super.key,
      required this.implementLeftBorder,
      required this.implementBorder,
      required this.h,
      required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              right: implementBorder
                  ? BorderSide(color: Color(0xffdddddd))
                  : BorderSide.none,
              left: implementLeftBorder && implementBorder
                  ? BorderSide(color: Color(0xffdddddd))
                  : BorderSide.none)),
      child: SizedBox(
        height: h,
        width: w,
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
