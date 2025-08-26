//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:flutter/material.dart';

class AdaptiveActionButton extends StatelessWidget {
  final IconData fallbackIcon;
  final String iconName;
  final VoidCallback onTap;

  const AdaptiveActionButton({
    @required this.fallbackIcon,
    @required this.iconName,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        color: Theme.of(context).primaryColor,
        child: AssetSvgIcon(
          showSvg: BuildProperty.useCustomContactIcons,
          svgPath: '${BuildProperty.image_dir}/contacts/$iconName.svg',
          iconData: fallbackIcon,
          width: 24.0,
          height: 24.0,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
