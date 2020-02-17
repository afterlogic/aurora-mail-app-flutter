import 'package:flutter/material.dart';

class AMAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final IconThemeData actionsIconTheme;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Color backgroundColor;
  final PreferredSizeWidget bottom;
  final double bottomOpacity;
  final Brightness brightness;
  final BoxShadow shadow;
  final Widget flexibleSpace;
  final IconThemeData iconTheme;
  final bool primary;
  final ShapeBorder shape;
  final TextTheme textTheme;
  final double titleSpacing;
  final double toolbarOpacity;

  const AMAppBar({
    Key key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.actionsIconTheme,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.bottom,
    this.bottomOpacity = 1.0,
    this.brightness,
    this.shadow,
    this.flexibleSpace,
    this.iconTheme,
    this.primary = true,
    this.shape,
    this.textTheme,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          shadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12.0,
                offset: Offset(0.0, 2.0),
              )
        ]),
        child: AppBar(
          leading: leading == null && canPop && !useCloseButton ? IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: Navigator.of(context).pop,
          ) : leading,
          centerTitle: centerTitle,
          title: title,
          actions: actions,
          actionsIconTheme: actionsIconTheme,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: backgroundColor,
          bottom: bottom,
          bottomOpacity: bottomOpacity,
          brightness: brightness,
          elevation: 0.0,
          flexibleSpace: flexibleSpace,
          iconTheme: iconTheme,
          primary: primary,
          shape: shape,
          textTheme: textTheme,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
        ),
      ),
    );
  }
}
