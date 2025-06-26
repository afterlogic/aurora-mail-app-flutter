//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveBottomBarIcon extends StatelessWidget {
  final IconData mdiIcon; // Стандартная иконка MDI
  final String iconName; // Имя иконки для SVG файлов (без расширения)
  final bool isActive; // Активна ли иконка
  final Color activeColor; // Цвет активной иконки
  final Color inactiveColor; // Цвет неактивной иконки
  final double size; // Размер иконки

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
    // Если включены кастомные иконки, используем SVG
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
      // Используем стандартные MDI иконки с цветовым окрашиванием
      return Icon(
        mdiIcon,
        color: isActive ? activeColor : inactiveColor,
        size: size,
      );
    }
  }
}
