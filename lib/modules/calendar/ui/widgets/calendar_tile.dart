import 'package:flutter/material.dart';

class CalendarTile extends StatelessWidget {
  const CalendarTile({super.key, this.backgroundColor = const Color(0xFFEDF5FE), required this.circleColor, required this.text});
  final Color? backgroundColor;
  final Color circleColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor == null ? null : Theme.of(context).brightness == Brightness.dark
              ? Colors.black45
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Text(text, style: TextStyle(),)
        ],
      ),
    );
  }
}
