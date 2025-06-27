//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/app_color.dart';

class AdaptiveDrawerIcon extends StatelessWidget {
  final IconData defaultIcon; // Стандартная иконка
  final String iconName; // Имя иконки для SVG файлов (без расширения)
  final Color color; // Цвет иконки
  final double size; // Размер иконки
  final String folder; // Папка с иконками (mail, contacts, etc.)

  const AdaptiveDrawerIcon({
    Key key,
    @required this.defaultIcon,
    @required this.iconName,
    this.color,
    this.size = 24.0,
    this.folder = 'mail', // по умолчанию mail для обратной совместимости
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Определяем цвет иконки
    Color iconColor;
    if (color != null) {
      // Если цвет явно передан, используем его
      iconColor = color;
    } else if (BuildProperty.useCustomDrawerIconColors) {
      // Если включены кастомные цвета drawer, используем AppColor
      iconColor = theme.brightness == Brightness.light
          ? AppColor.drawerIconLight
          : AppColor.drawerIconDark;
    } else {
      // Иначе используем цвет из темы
      final IconThemeData iconTheme = IconTheme.of(context);
      iconColor = iconTheme.color;
    }

    // Если включены кастомные иконки для drawer, используем SVG
    if (BuildProperty.useCustomDrawerIcons) {
      final iconPath =
          '${BuildProperty.image_dir}/drawer/${folder}/${iconName}.svg';

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
