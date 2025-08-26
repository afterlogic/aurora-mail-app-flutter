//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

import 'asset_svg_icon.dart';

class AdaptiveBottomBarIcon extends StatelessWidget {
  final IconData defaultIcon; // The standard MDI icon
  final String iconName; // Icon name for SVG files (without extension)
  final bool isActive; // Is the icon active
  final Color activeColor; // The color of the active icon
  final Color inactiveColor; // The color of the inactive icon
  final double size; // Icon Size

  const AdaptiveBottomBarIcon({
    @required this.defaultIcon,
    @required this.iconName,
    @required this.isActive,
    @required this.activeColor,
    @required this.inactiveColor,
    this.size = 28.0,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive ? activeColor : inactiveColor;
    final iconPath = isActive
        ? '${BuildProperty.image_dir}/bottom-app-bar/${iconName}.active.svg'
        : '${BuildProperty.image_dir}/bottom-app-bar/${iconName}.svg';

    return SizedBox(
      width: size,
      height: size,
      child: AssetSvgIcon(
        showSvg: BuildProperty.useCustomBottomBarIcons,
        svgPath: iconPath,
        iconData: defaultIcon,
        width: size,
        height: size,
        color: iconColor,
      ),
    );
  }
}
