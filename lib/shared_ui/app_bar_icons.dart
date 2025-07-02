//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/app_color.dart';

class AppBarIcons {
  // burger icon
  static Widget burger({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/burger.svg',
        width: 18.0,
        height: 14.0,
        color: iconColor,
      );
    }
    return Icon(Icons.menu, size: size, color: iconColor);
  }

  // search
  static Widget search({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/search.svg',
        width: 20.0,
        height: 20.0,
        color: iconColor,
      );
    }
    return Icon(Icons.search, size: size, color: iconColor);
  }

  // close
  static Widget close({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/close.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.arrow_back, size: size, color: iconColor);
  }

  // back
  static Widget back({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/back.svg',
        width: 16.0,
        height: 12.0,
        color: iconColor,
      );
    }
    return Icon(Icons.arrow_back, size: size, color: iconColor);
  }

  // info
  static Widget info({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/info.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.info_outline, size: size, color: iconColor);
  }

  // send
  static Widget send({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/send.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.send, size: size, color: iconColor);
  }

  // menu
  static Widget menu({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.more_vert, size: size, color: iconColor);
  }

  // drafts
  static Widget drafts({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/drafts.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.drafts, size: size, color: iconColor);
  }

  // edit
  static Widget edit({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-edit.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.edit, size: size, color: iconColor);
  }

  // delete
  static Widget delete({BuildContext context, Color color, double size}) {
    final iconColor = color ?? (Theme.of(context).brightness == Brightness.light 
        ? AppColor.appBarIconLight 
        : AppColor.appBarIconDark);
    
    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-delete.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.delete_outline, size: size, color: iconColor);
  }
}
