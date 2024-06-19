import 'package:flutter/material.dart';

class SectionWithIcon extends StatelessWidget {
  const SectionWithIcon({super.key, required this.children, required this.icon});

  final List<Widget> children;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      icon,
      const SizedBox(
        width: 8,
      ),
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children),
      ),
    ]);
  }
}