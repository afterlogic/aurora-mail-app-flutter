
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/adaptive_bottom_bar_icon.dart';
import 'package:flutter/material.dart';

class AdaptiveBottomBarButton extends StatelessWidget {
  final IconData mdiIcon;
  final String iconName;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onPressed;
  final double iconSize;

  const AdaptiveBottomBarButton({
    Key? key,
    required this.mdiIcon,
    required this.iconName,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onPressed,
    this.iconSize = 28.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creating a fixed container for the icon
    final iconWidget = Container(
      width: iconSize,
      height: iconSize,
      alignment: Alignment.center,
      child: AdaptiveBottomBarIcon(
        defaultIcon: mdiIcon,
        iconName: iconName,
        isActive: isActive,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        size: iconSize,
      ),
    );

    // If icon labels are enabled
    if (BuildProperty.showBottomBarLabels) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          width: 80.0, // Fixed width for the entire button
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(height: 4.0),
              Container(
                height: 16.0, // Fixed height for text
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: isActive ? activeColor : inactiveColor,
                    fontWeight: FontWeight.normal, // Always the same weight
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // A regular button without a signature is a fixed size.
      return Container(
        width: iconSize + 16.0, // Icon size + IconButton margins
        height: iconSize + 16.0,
        child: IconButton(
          icon: iconWidget,
          tooltip: label,
          onPressed: onPressed,
          padding: EdgeInsets.all(8.0),
        ),
      );
    }
  }
}
