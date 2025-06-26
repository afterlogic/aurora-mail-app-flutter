//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/app_color.dart';

class AdaptiveSettingsMenuIcon extends StatelessWidget {
  final IconData defaultIcon; // Стандартная иконка MDI
  final String iconName; // Имя иконки для SVG файлов (без расширения)
  final Color color; // Цвет иконки
  final Color background; // Цвет фона
  final String iconFolder; // Папка с иконками (menu, common, etc.)

  const AdaptiveSettingsMenuIcon({
    Key key,
    @required this.defaultIcon,
    @required this.iconName,
    @required this.color,
    @required this.background,
    this.iconFolder = 'menu', // по умолчанию menu
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Определяем цвет для кастомных иконок
    Color iconColor = color;
    if (BuildProperty.useCustomSettingsColors) {
      final isDarkTheme = theme.brightness == Brightness.dark;
      iconColor =
          isDarkTheme ? AppColor.settingsIconDark : AppColor.settingsIconLight;
    }

    // Если есть кастомная иконка для данного билд-варианта, используем SVG
    if (BuildProperty.useCustomSettingsIcons) {
      final iconPath =
          '${BuildProperty.image_dir}/settings/${iconFolder}/${iconName}.svg';

      return SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: iconColor,
            placeholderBuilder: (context) {
              // Fallback к стандартной иконке, если SVG не найден
              return Icon(
                defaultIcon,
                color: iconColor,
                size: 24,
              );
            },
          ),
        ),
      );
    } else {
      // Используем стандартную иконку
      return AMCircleIcon(
        defaultIcon,
        color: color,
        background: background,
      );
    }
  }
}
