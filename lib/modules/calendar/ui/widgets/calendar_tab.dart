import 'package:flutter/material.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab(
      {super.key,
      required this.title,
      required this.controller,
      required this.index});

  final String title;
  final TabController controller;
  final int index;

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  void controllerListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(controllerListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.controller.animateTo(widget.index);
      },
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: widget.controller.index == widget.index
              ? Theme.of(context).primaryColor
              : Colors.transparent, width: 2))
        ),
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 16,
              color: widget.controller.index == widget.index
                  ? Theme.of(context).primaryColor
                  : Color.fromRGBO(169, 169, 169, 1)),
        ),
      ),
    );
  }
}
