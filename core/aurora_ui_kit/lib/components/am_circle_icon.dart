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
    final theme = Theme.of(context);
    final defaultBG = theme.brightness == Brightness.dark
        ? theme.accentColor.withOpacity(0.2)
        : theme.accentColor.withOpacity(0.06);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        //color: background ?? defaultBG,
        color: background ?? defaultBG,
        borderRadius: radius ?? BorderRadius.circular(100.0),
      ),
      child: Icon(
        icon,
        color: color ?? theme.iconTheme.color,
        semanticLabel: semanticLabel,
        size: size,
        textDirection: textDirection,
      ),
    );
  }
}
