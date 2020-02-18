import 'package:flutter/material.dart';

class AMAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  _AMAppBarState createState() => _AMAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AMAppBarState extends State<AMAppBar> {

  void _handleBackButton() {
    Navigator.maybePop(context);
  }

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {

    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          widget.shadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12.0,
                offset: Offset(0.0, 2.0),
              )
        ]),
        child: AppBar(
          leading: _leading,
          centerTitle: widget.centerTitle,
          title: widget.title,
          actions: widget.actions,
          actionsIconTheme: widget.actionsIconTheme,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          backgroundColor: widget.backgroundColor,
          bottom: widget.bottom,
          bottomOpacity: widget.bottomOpacity,
          brightness: widget.brightness,
          elevation: 0.0,
          flexibleSpace: widget.flexibleSpace,
          iconTheme: widget.iconTheme,
          primary: widget.primary,
          shape: widget.shape,
          textTheme: widget.textTheme,
          titleSpacing: widget.titleSpacing,
          toolbarOpacity: widget.toolbarOpacity,
        ),
      ),
    );
  }

  Widget get _leading {
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    if (widget.leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        return IconButton(
          icon: const Icon(Icons.sort),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop) {
          if (useCloseButton) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: _handleBackButton,
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _handleBackButton,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          }
        }
      }
    }
    return widget.leading;
  }

  List<Widget> get actions {
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;

    if ((widget.actions == null || widget.actions.isEmpty) && hasEndDrawer) {
      return [IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      )];
    } else {
      return widget.actions;
    }
  }
}
