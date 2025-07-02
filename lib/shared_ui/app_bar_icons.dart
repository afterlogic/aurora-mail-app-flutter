//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarIcons {
  // burger icon
  static Widget burger({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/burger.svg',
        width: 16.0,
        height: 12.0,
        color: color,
      );
    }
    return Icon(Icons.menu, size: size, color: Colors.black);
  }

  // search
  static Widget search({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/search.svg',
        width: 20.0,
        height: 20.0,
        color: color,
      );
    }
    return Icon(Icons.search, size: size, color: Colors.black);
  }

  // close
  static Widget close({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/close.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.arrow_back, size: size, color: Colors.black);
  }

  // back
  static Widget back({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/back.svg',
        width: 16.0,
        height: 12.0,
        color: color,
      );
    }
    return Icon(Icons.arrow_back, size: size, color: Colors.black);
  }

  // info
  static Widget info({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/info.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.info_outline, size: size, color: Colors.black);
  }

  // send
  static Widget send({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/send.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.send, size: size, color: Colors.black);
  }

  // menu
  static Widget menu({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.more_vert, size: size, color: Colors.black);
  }

  // drafts
  static Widget drafts({Color color, double size}) {
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/drafts.svg',
        width: 24.0,
        height: 24.0,
        color: color,
      );
    }
    return Icon(Icons.drafts, size: size, color: Colors.black);
  }
}
