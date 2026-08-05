
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/shared_ui/asset_svg_icon.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:flutter/material.dart';
import 'package:theme/app_color.dart';

class Star extends StatefulWidget {
  final bool value;
  final bool enabled;
  final Function(bool) onPressed;

  const Star({
    Key? key,
    required this.value,
    this.enabled = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends BState<Star> with TickerProviderStateMixin {
  final _animDuration = new Duration(milliseconds: 130);
  late AnimationController _parentCtrl;
  late Animation<double> _scaleAnimation;
  late bool _isStarred;

  @override
  void initState() {
    super.initState();
    _isStarred = widget.value;
    _parentCtrl = new AnimationController(vsync: this, duration: _animDuration);
    _parentCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _parentCtrl.reverse();
      }
    });
    _parentCtrl.addListener(() {
      setState(() {});
    });
    _scaleAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
        new CurvedAnimation(parent: _parentCtrl, curve: Curves.easeInOut));
  }

  Future _setStarred(bool isStarred) async {
    _parentCtrl.forward(from: 0.0);
    setState(() => _isStarred = isStarred);
    // wait forward and reverse
    await Future.delayed(_animDuration);
    await Future.delayed(_animDuration);
    widget.onPressed(isStarred);
  }

  @override
  void didUpdateWidget(Star oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isStarred = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    // Define colors depending on the theme.
    final starActiveColor = AppColor.starActive;
    final starInactiveColor = theme.brightness == Brightness.light
        ? AppColor.starInactiveLight
        : AppColor.starInactiveDark;

    if (_isStarred) {
      return Transform.scale(
        scale: 1 + _scaleAnimation.value / 4,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: AssetSvgIcon(
            showSvg: BuildProperty.useCustomStarIcons,
            svgPath: '${BuildProperty.image_dir}/mail/star.active.svg',
            iconData: Icons.star,
            color: starActiveColor,
          ),
          onPressed: widget.enabled ? () => _setStarred(false) : null,
        ),
      );
    } else {
      return Transform.scale(
        scale: 1 - _scaleAnimation.value / 7,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: AssetSvgIcon(
            showSvg: BuildProperty.useCustomStarIcons,
            svgPath: '${BuildProperty.image_dir}/mail/star.svg',
            iconData: Icons.star_border,
            color: widget.enabled ? starInactiveColor : theme.disabledColor,
          ),
          onPressed: widget.enabled ? () => _setStarred(true) : null,
        ),
      );
    }
  }
}
