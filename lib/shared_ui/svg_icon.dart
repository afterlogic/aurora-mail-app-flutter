import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final double size;

  final String asset;

  final Color color;

  const SvgIcon(this.asset, {Key key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    final double iconSize = size ?? iconTheme.size;

    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;
    if (iconOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);

    return SvgPicture.asset(
      asset,
      width: iconSize,
      height: iconSize,
      color: iconColor,
    );
  }
}
