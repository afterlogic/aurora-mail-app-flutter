import 'package:flutter/material.dart';

class ColorSelectionField extends StatelessWidget {
  final List<Color> colors;
  final Color? selectedColor;
  final Function(Color) onColorTap;

  const ColorSelectionField(
      {required this.colors,
      this.selectedColor,
      required this.onColorTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            onColorTap(color);
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: selectedColor == color
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
            child: selectedColor == color
                ? Icon(Icons.check, color: Colors.white)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
