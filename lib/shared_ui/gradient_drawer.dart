import 'package:aurora_mail/build_property.dart';
import 'package:flutter/material.dart';

class GradientDrawer extends StatelessWidget {
  final Widget child;

  const GradientDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Используем новую настройку специально для градиента drawer'а
    final bool useGradient = BuildProperty.useDrawerGradient == true;

    return Drawer(
      child: useGradient
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      BuildProperty.image_dir + '/login_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: child,
            )
          : child, // Обычный белый фон для других сборок
    );
  }
}
