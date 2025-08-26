//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

import 'asset_svg_icon.dart';

class AdaptiveDrawerIcon extends StatelessWidget {
  final IconData defaultIcon; // Standard icon
  final String iconName; // Icon name for SVG files (without extension)
  final Color color; // Icon color
  final double size; // Icon size
  final String folder; // Folder with icons (mail, contacts, etc.)

  const AdaptiveDrawerIcon({
    @required this.defaultIcon,
    @required this.iconName,
    this.color,
    this.size = 24.0,
    this.folder = 'mail', // default mail for backward compatibility
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Defining the icon color
    Color iconColor;
    if (color != null) {
      // If the color is explicitly passed, we use it.
      iconColor = color;
    } else if (BuildProperty.useCustomDrawerIconColors) {
      // If custom drawer colors are enabled, use AppColor.
      iconColor = theme.brightness == Brightness.light
          ? AppColor.drawerIconLight
          : AppColor.drawerIconDark;
    } else {
      // Otherwise, we'll use the color from the theme.
      final IconThemeData iconTheme = IconTheme.of(context);
      iconColor = iconTheme.color;
    }

    final iconPath =
        '${BuildProperty.image_dir}/drawer/${folder}/${iconName}.svg';

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomDrawerIcons,
      svgPath: iconPath,
      iconData: defaultIcon,
      width: size,
      height: size,
      color: iconColor,
    );
  }
}
