import 'package:flutter/material.dart';

class ColoredCheckbox extends StatelessWidget {
  final Color color;
  final bool? value;
  final Function(bool?)? onChanged;

  ColoredCheckbox({required this.color, this.value, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: color, // This changes the color of the border of the unchecked checkbox
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
      child: Checkbox(

        value: value,

        activeColor: color,
        checkColor: Colors.white,
        onChanged: onChanged
      ),
    );
  }
}

