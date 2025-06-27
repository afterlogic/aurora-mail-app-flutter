//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveContactIcon extends StatelessWidget {
  final IconData fallbackIcon;
  final String iconName;
  final Color color;
  final double size;

  const AdaptiveContactIcon({
    Key key,
    @required this.fallbackIcon,
    @required this.iconName,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (BuildProperty.useCustomContactIcons) {
      final iconPath = '${BuildProperty.image_dir}/contacts/$iconName.svg';

      return SvgPicture.asset(
        iconPath,
        width: size ?? 24.0,
        height: size ?? 24.0,
        color: color ?? Theme.of(context).primaryColor,
        // Если иконка не найдена, показываем fallback
        placeholderBuilder: (context) => Icon(
          fallbackIcon,
          color: color ?? Theme.of(context).primaryColor,
          size: size ?? 24.0,
        ),
      );
    }

    return Icon(
      fallbackIcon,
      color: color ?? Theme.of(context).primaryColor,
      size: size ?? 24.0,
    );
  }
}
