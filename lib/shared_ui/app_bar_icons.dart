
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:theme/app_color.dart';

class AppBarIcons {
  // burger icon
  static Widget burger({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/burger.svg',
      iconData: Icons.menu,
      width: 18.0,
      height: 14.0,
      color: iconColor,
    );
  }

  // search
  static Widget search({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/search.svg',
      iconData: Icons.search,
      width: 20.0,
      height: 20.0,
      color: iconColor,
    );
  }

  // close
  static Widget close({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/close.svg',
      iconData: Icons.arrow_back,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // back
  static Widget back({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/back.svg',
      iconData: Icons.arrow_back,
      width: 16.0,
      height: 12.0,
      color: iconColor,
    );
  }

  // info
  static Widget info({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/info.svg',
      iconData: Icons.info_outline,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // send
  static Widget send({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/send.svg',
      iconData: Icons.send,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // menu
  static Widget menu({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu.svg',
      iconData: Icons.more_vert,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // drafts
  static Widget drafts({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/drafts.svg',
      iconData: Icons.drafts,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // edit
  static Widget edit({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-edit.svg',
      iconData: Icons.edit,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // edit-underline
  static Widget editUnderline({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-edit-underline.svg',
      iconData: Icons.edit,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // delete
  static Widget delete({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-delete.svg',
      iconData: Icons.delete_outline,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // delete
  static Widget deleteEmpty({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-delete-empty.svg',
      iconData: Icons.delete_forever,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // reply
  static Widget reply({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-reply.svg',
      iconData: Icons.reply,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // reply_all
  static Widget replyAll({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-reply-to-all.svg',
      iconData: Icons.reply_all,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // forward
  static Widget forward({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-forward.svg',
      iconData: Icons.forward,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // move
  static Widget move({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-move-to-folder.svg',
      iconData: Icons.folder_open,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // headers
  static Widget headers({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath:
          '${BuildProperty.image_dir}/m-app-bar/menu-view-message-headers.svg',
      iconData: Icons.code,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // forward_as_attachment
  static Widget forwardAsAttachment({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-attach.svg',
      iconData: Icons.forward,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // resend
  static Widget resend({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-resend.svg',
      iconData: Icons.send,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // spam
  static Widget spam({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-spam.svg',
      iconData: MdiIcons.alertOctagonOutline,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }

  // not-spam
  static Widget not_spam({BuildContext? context, Color? color}) {
    final iconColor = color ??
        (Theme.of(context!).brightness == Brightness.light
            ? AppColor.appBarIconLight
            : AppColor.appBarIconDark);

    return AssetSvgIcon(
      showSvg: BuildProperty.useCustomAppBarIcons,
      svgPath: '${BuildProperty.image_dir}/m-app-bar/menu-not-spam.svg',
      iconData: MdiIcons.checkCircleOutline,
      width: 24.0,
      height: 24.0,
      color: iconColor,
    );
  }
}
