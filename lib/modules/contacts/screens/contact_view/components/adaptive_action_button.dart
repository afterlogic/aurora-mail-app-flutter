//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveActionButton extends StatelessWidget {
  final IconData fallbackIcon;
  final String iconName;
  final void Function() cb;

  const AdaptiveActionButton({
    Key key,
    @required this.fallbackIcon,
    @required this.iconName,
    @required this.cb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        color: Theme.of(context).primaryColor,
        child: BuildProperty.useCustomContactIcons
            ? SvgPicture.asset(
                '${BuildProperty.image_dir}/contacts/$iconName.svg',
                width: 24.0,
                height: 24.0,
                color: Colors.white,
                // Если иконка не найдена, показываем fallback
                placeholderBuilder: (context) => Icon(
                  fallbackIcon,
                  color: Colors.white,
                ),
              )
            : Icon(
                fallbackIcon,
                color: Colors.white,
              ),
      ),
      onTap: cb,
    );
  }
}
