//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveBottomBarIcon extends StatelessWidget {
  final IconData mdiIcon; // The standard MDI icon
  final String iconName; // Icon name for SVG files (without extension)
  final bool isActive; // Is the icon active
  final Color activeColor; // The color of the active icon
  final Color inactiveColor; // The color of the inactive icon
  final double size; // Icon Size

  const AdaptiveBottomBarIcon({
    Key key,
    @required this.mdiIcon,
    @required this.iconName,
    @required this.isActive,
    @required this.activeColor,
    @required this.inactiveColor,
    this.size = 28.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If custom icons are enabled, use SVG
    if (BuildProperty.useCustomBottomBarIcons) {
      final iconPath = isActive
          ? 'build_res/unlyme/image/bottom-app-bar/${iconName}.active.svg'
          : 'build_res/unlyme/image/bottom-app-bar/${iconName}.svg';

      return SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          iconPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
          color: isActive ? activeColor : inactiveColor,
          placeholderBuilder: (context) {
            return Icon(
              mdiIcon,
              color: isActive ? activeColor : inactiveColor,
              size: size,
            );
          },
        ),
      );
    } else {
      // We use standard MDI icons with color coloring
      return Icon(
        mdiIcon,
        color: isActive ? activeColor : inactiveColor,
        size: size,
      );
    }
  }
}
