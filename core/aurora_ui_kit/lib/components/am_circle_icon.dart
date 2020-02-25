import 'package:flutter/material.dart';

class AMCircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final EdgeInsets padding;
  final BorderRadius radius;
  final String semanticLabel;
  final double size;
  final TextDirection textDirection;

  const AMCircleIcon(
    this.icon, {
    Key key,
    this.color,
    this.semanticLabel,
    this.padding = const EdgeInsets.all(8.0),
    this.size,
    this.textDirection,
    this.background,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).iconTheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? theme.color.withOpacity(0.06),
        borderRadius: radius ?? BorderRadius.circular(100.0),
      ),
      child: Icon(
        icon,
        color: color ?? theme.color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      ),
    );
  }
}
