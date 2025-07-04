//@dart=2.9
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/res/icons/app_assets.dart';
import 'package:aurora_mail/shared_ui/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/app_color.dart';

class AppBarIcons {
  // burger icon
  static Widget burger({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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

  // edit-underline
  static Widget editUnderline({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-edit-underline.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.edit, size: size, color: iconColor);
  }

  // delete
  static Widget delete({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
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

  // delete
  static Widget deleteEmpty({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-delete-empty.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.delete_forever, size: size, color: iconColor);
  }

  // reply
  static Widget reply({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-forward.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.reply, size: size, color: iconColor);
  }

  // reply_all
  static Widget replyAll({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-reply-to-all.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.reply_all, size: size, color: iconColor);
  }

  // forward
  static Widget forward({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-forward.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.forward, size: size, color: iconColor);
  }

  // move
  static Widget move({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-move-to-folder.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.folder_open, size: size, color: iconColor);
  }

  // headers
  static Widget headers({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-view-message-headers.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.code, size: size, color: iconColor);
  }

  // forward_as_attachment
  static Widget forwardAsAttachment(
      {BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-attach.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.forward, size: size, color: iconColor);
  }

  // resend
  static Widget resend({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-resend.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return Icon(Icons.send, size: size, color: iconColor);
  }

  // spam
  static Widget spam({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-spam.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return SvgIcon(AppAssets.spam);
  }

  // not-spam
  static Widget not_spam({BuildContext context, Color color, double size}) {
    final iconColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    if (BuildProperty.useCustomAppBarIcons) {
      return SvgPicture.asset(
        '${BuildProperty.image_dir}/m-app-bar/menu-not-spam.svg',
        width: 24.0,
        height: 24.0,
        color: iconColor,
      );
    }
    return SvgIcon(AppAssets.not_spam);
  }
}
