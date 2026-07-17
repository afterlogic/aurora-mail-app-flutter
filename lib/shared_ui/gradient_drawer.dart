import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

class GradientDrawer extends StatelessWidget {
  final Widget child;

  const GradientDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using a new setting specifically for the drawer gradient
    final bool useGradient = BuildProperty.useDrawerGradient == true;

    return Drawer(
      child: useGradient
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      BuildProperty.image_dir + '/drawer_gradient.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: child,
            )
          : child, // The usual white background for other builds
    );
  }
}
