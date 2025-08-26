//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

import 'asset_svg_icon.dart';

/// EN: Icon for settings menu
class AdaptiveSettingsMenuIcon extends StatelessWidget {
  final IconData defaultIcon; // The standard MDI icon
  final String iconName; // Icon name for SVG files (without extension)
  final Color color; // Icon color
  final Color background; // Background color
  final String iconFolder; // Folder with icons (menu, common, etc.)

  const AdaptiveSettingsMenuIcon({
    @required this.defaultIcon,
    @required this.iconName,
    @required this.color,
    @required this.background,
    this.iconFolder = 'menu', // default mail for backward compatibility
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Defining the color for custom icons
    Color iconColor = color;
    if (BuildProperty.useCustomSettingsColors) {
      final isDarkTheme = theme.brightness == Brightness.dark;
      iconColor =
          isDarkTheme ? AppColor.settingsIconDark : AppColor.settingsIconLight;
    }

    final iconSize = 24.0;

    // If there is a custom icon for this build option, use SVG
    if (BuildProperty.useCustomSettingsIcons) {
      final iconPath =
          '${BuildProperty.image_dir}/settings/${iconFolder}/${iconName}.svg';

      return SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: AssetSvgIcon(
            showSvg: true,
            svgPath: iconPath,
            iconData: defaultIcon,
            width: iconSize,
            height: iconSize,
            color: iconColor,
          ),
        ),
      );
    }

    // We use the standard icon
    return AMCircleIcon(
      defaultIcon,
      color: color,
      size: iconSize,
      background: background,
    );
  }
}
