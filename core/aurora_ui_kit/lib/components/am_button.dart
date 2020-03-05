import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AMButton extends StatelessWidget {
  final Duration animationDuration;
  final bool autofocus;
  final Widget child;
  final Clip clipBehavior;
  final Color color;
  final BoxShadow shadow;
  final Brightness colorBrightness;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color focusColor;
  final FocusNode focusNode;
  final double height;
  final Color highlightColor;
  final Color hoverColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final void Function() onPressed;
  final void Function() onLongPress;
  final void Function() onHighlightChanged;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Color splashColor;
  final Color textColor;
  final ButtonTextTheme textTheme;
  final bool isLoading;

  const AMButton({
    Key key,
    this.isLoading,
    @required this.onPressed,
    this.animationDuration,
    this.autofocus = false,
    @required this.child,
    this.clipBehavior = Clip.none,
    this.color,
    this.shadow,
    this.colorBrightness,
    this.disabledColor,
    this.disabledTextColor,
    this.focusColor,
    this.focusNode,
    this.height,
    this.highlightColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.onLongPress,
    this.onHighlightChanged,
    this.padding,
    this.shape,
    this.splashColor,
    this.textColor,
    this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: isLoading == true
            ? null
            : [
                shadow ??
                    BoxShadow(
                      color: theme.floatingActionButtonTheme.hoverColor,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 3.0),
                    ),
              ],
      ),
      child: RaisedButton(
        elevation: 0.0,
        disabledElevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        hoverElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: isLoading == true ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: isLoading == true
                ? SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : child,
          ),
        ),
        animationDuration: animationDuration,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        color: color,
        colorBrightness: colorBrightness,
        disabledColor: disabledColor,
        disabledTextColor: disabledTextColor,
        focusColor: focusColor,
        focusNode: focusNode,
        highlightColor: highlightColor,
        hoverColor: hoverColor,
        materialTapTargetSize: materialTapTargetSize,
        onLongPress: onLongPress,
        padding: padding,
        splashColor: splashColor,
        textColor: textColor,
        textTheme: textTheme ?? theme.buttonTheme.textTheme,
      ),
    );
  }
}
