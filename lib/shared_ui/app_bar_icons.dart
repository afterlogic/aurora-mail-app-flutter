//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarIcons {
  // Простая функция для получения burger icon
  static Widget burger({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/burger.svg',
        width: 16.0,
        height: 12.0,
      );
    }
    return Icon(Icons.menu, color: color, size: size);
  }

  // Простая функция для получения search icon
  static Widget search({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/search.svg',
        width: 20.0,
        height: 20.0,
      );
    }
    return Icon(Icons.search, color: color, size: size);
  }

  // Простая функция для получения close/exit icon
  static Widget close({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/close.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.arrow_back, color: color, size: size);
  }

  // Простая функция для получения back/exit icon (стрелка назад)
  static Widget back({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/back.svg',
        width: 16.0,
        height: 12.0,
        color: color,
      );
    }
    return Icon(Icons.arrow_back, color: color, size: size);
  }

  // Простая функция для получения back/exit icon (стрелка назад)
  static Widget info({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/info.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.info_outline, color: color, size: size);
  }
}
