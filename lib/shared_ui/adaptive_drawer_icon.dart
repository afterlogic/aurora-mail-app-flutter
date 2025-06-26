//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdaptiveDrawerIcon extends StatelessWidget {
  final IconData defaultIcon; // Стандартная иконка
  final String iconName; // Имя иконки для SVG файлов (без расширения)
  final Color color; // Цвет иконки
  final double size; // Размер иконки

  const AdaptiveDrawerIcon({
    Key key,
    @required this.defaultIcon,
    @required this.iconName,
    this.color,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final Color iconColor = color ?? iconTheme.color;

    // Если включены кастомные иконки для drawer, используем SVG
    if (BuildProperty.useCustomDrawerIcons) {
      final iconPath =
          '${BuildProperty.image_dir}/drawer/mail/${iconName}.svg';

      return SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        color: iconColor,
        placeholderBuilder: (context) {
          // Fallback к стандартной иконке, если SVG не найден
          return Icon(
            defaultIcon,
            color: iconColor,
            size: size,
          );
        },
      );
    } else {
      // Используем стандартную иконку
      return Icon(
        defaultIcon,
        color: iconColor,
        size: size,
      );
    }
  }
}
