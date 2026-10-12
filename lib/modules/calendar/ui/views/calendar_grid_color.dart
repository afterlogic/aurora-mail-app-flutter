import 'package:flutter/material.dart';

/// Color of the week/day grid lines. Resolved the same way as the color of a
/// plain [Divider] (e.g. the one in the calendar drawer), so they always match.
Color calendarGridColor(BuildContext context) {
  return DividerTheme.of(context).color ??
      Theme.of(context).colorScheme.outlineVariant;
}
