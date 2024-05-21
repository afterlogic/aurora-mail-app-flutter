import 'dart:math';

import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';

class CalendarDrawer extends StatefulWidget {
  @override
  _CalendarDrawerState createState() => _CalendarDrawerState();
}

class _CalendarDrawerState extends BState<CalendarDrawer> {
  static const _horizontalHeaderPadding = 24.0;
  static const _horizontalSectionPadding = 22.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        selectedColor: theme.primaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                        horizontal: _horizontalHeaderPadding)
                    .copyWith(top: 16, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My calendars',
                        style: TextStyle(color: theme.disabledColor)),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
              ),
              const Divider(
                color: const Color(0xFFF1F1F1),
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: _horizontalSectionPadding, right: _horizontalHeaderPadding)
                    .copyWith(top: 12,),
                child: CollapsibleCheckboxList(
                    title: 'MyCalendar',
                    items:
                        List<String>.generate(5, (index) => 'Item ${index + 1}')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollapsibleCheckboxList extends StatefulWidget {
  final String title;
  final List<String> items;

  CollapsibleCheckboxList({required this.title, required this.items});

  @override
  _CollapsibleCheckboxListState createState() =>
      _CollapsibleCheckboxListState();
}

class _CollapsibleCheckboxListState extends State<CollapsibleCheckboxList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isChecked = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(

                  value: _isChecked,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Text(widget.title),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationController.value *
                        pi, // 180 degrees in radians
                    child: Icon(Icons.keyboard_arrow_down),
                  );
                },
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _animationController,
          child: Column(
            children: widget.items
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(item),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
