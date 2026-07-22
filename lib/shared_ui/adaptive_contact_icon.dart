
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

import 'asset_svg_icon.dart';

class AdaptiveContactIcon extends StatelessWidget {
  final IconData defaultIcon;
  final String? iconName;
  final Color? color;
  final double size;

  const AdaptiveContactIcon({
    required this.defaultIcon,
    required this.iconName,
    this.color,
    this.size = 24.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).primaryColor;
    final iconPath = '${BuildProperty.image_dir}/contacts/$iconName.svg';

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomContactIcons,
      svgPath: iconPath,
      iconData: defaultIcon,
      width: size,
      height: size,
      color: iconColor,
    );
  }
}
