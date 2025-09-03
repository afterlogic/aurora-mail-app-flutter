import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? value;
  final Color? color;
  final double? size;
  final double? strokeWidth;

  const LoadingIndicator({
    this.value,
    this.color,
    this.size,
    this.strokeWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actualSize = size ?? 32;

    return RepaintBoundary(
      child: SizedBox(
        width: actualSize,
        height: actualSize,
        child: CircularProgressIndicator(
          value: value,
          color: color ?? Theme.of(context).primaryColor,
          strokeWidth: strokeWidth ?? 2,
        ),
      ),
    );
  }
}
