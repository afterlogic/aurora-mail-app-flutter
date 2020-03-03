import 'package:flutter/material.dart';

class AMFloatingActionButton extends StatelessWidget {
  final bool autofocus;
  final Color backgroundColor;
  final Widget child;
  final BoxShadow shadow;
  final Clip clipBehavior;
  final Color focusColor;
  final FocusNode focusNode;
  final Color foregroundColor;
  final Object heroTag;
  final Color hoverColor;
  final bool isExtended;
  final Key key;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool mini;
  final void Function() onPressed;
  final ShapeBorder shape;
  final Color splashColor;
  final String tooltip;

  const AMFloatingActionButton({
    this.key,
    this.autofocus = false,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.focusColor,
    this.shadow,
    this.focusNode,
    this.foregroundColor,
    this.heroTag = const _DefaultHeroTag(),
    this.hoverColor,
    this.isExtended = false,
    this.materialTapTargetSize,
    this.mini = false,
    @required this.onPressed,
    this.shape,
    this.splashColor,
    this.tooltip,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: onPressed == null
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
      child: FloatingActionButton(
        key: key,
        autofocus: autofocus,
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior,
        focusColor: focusColor,
        focusElevation: 0.0,
        focusNode: focusNode,
        foregroundColor: foregroundColor,
        heroTag: heroTag,
        highlightElevation: 0.0,
        hoverColor: hoverColor,
        hoverElevation: 0.0,
        elevation: 0.0,
        isExtended: isExtended,
        materialTapTargetSize: materialTapTargetSize,
        mini: mini,
        onPressed: onPressed,
        shape: shape,
        splashColor: splashColor,
        tooltip: tooltip,
        child: child,
      ),
    );
  }
}

class _DefaultHeroTag {
  const _DefaultHeroTag();

  @override
  String toString() => '<default FloatingActionButton tag>';
}
