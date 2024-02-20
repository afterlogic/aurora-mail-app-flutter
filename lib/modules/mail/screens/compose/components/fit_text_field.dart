//@dart=2.9
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';

class FitTextField extends StatefulWidget {
  final Widget child;
  final TextEditingController controller;
  final double minWidth;

  const FitTextField(
      {Key key,
      @required this.child,
      @required this.controller,
      this.minWidth: 5})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new FitTextFieldState();
}

class FitTextFieldState extends BState<FitTextField> {
  TextStyle textStyle = TextStyle(color: Colors.grey[600]);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_update);
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    // Use TextPainter to calculate the width of our text
    TextSpan ts = new TextSpan(style: textStyle, text: widget.controller.text);
    TextPainter tp =
        new TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    final testScale = MediaQuery.of(context).textScaleFactor;
    var textWidth = tp.width *
        (testScale +
            0.3); // We will use this width for the container wrapping our TextField
    // Enforce a minimum width
    if (textWidth < widget.minWidth) {
      textWidth = widget.minWidth;
    }

    return Container(
      width: textWidth,
      child: widget.child,
    );
  }
}
