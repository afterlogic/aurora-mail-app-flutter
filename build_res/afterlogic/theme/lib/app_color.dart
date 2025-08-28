import 'package:flutter/material.dart';

class AppColor {
  // Main palette
  static const primary = const Color(0xFF009FFF);
  static const primaryVariant = primary;
  static const secondary = primary;
  static const secondaryVariant = primary;
  static const accent = primary;
  static const accentVariant = primary;
  static const surface = Color(0xFFFFFFFF);
  static const warning = Color(0xFFF44336);

  // UI Components
  static const appBarBackground = Color(0xFFF4F1FD);
  static const appBarText = Color(0xFF212121); // for compatibility
  static const appBarDivider =
      Color(0xFFEBEBEB); // only used when useAppBarDivider is enabled
  static const bottomNavigationBackground = Color(0xFFF4F1FD);

  // Text colors
  static const contactsPrimary = Color(0xFF212121); // for compatibility

  // Input styles (for compatibility)
  static const inputBackground = Color(0xFFF5F5F5);
  static const inputBorder = Color(0xFFE0E0E0);
  static const inputPlaceholder = Color(0xFF757575);

  // Input sections and groups (for compatibility)
  static const sectionBackground = Color(0xFFF5F5F5);
  static const sectionText = Color(0xFF212121);
  static const inputGroupBackground = Color(0xFFF5F5F5);
  static const inputGroupBorder = Color(0xFFE0E0E0);

  // Mail specific
  // Star icon colors (default)
  static const starActive = Color(0xFFFFC107);
  static const starInactiveLight = Color(0xFFB0B0B0);
  static const starInactiveDark = Color(0xFF808080);

  // Icon colors
  // AppBar icons
  static const appBarIconLight = Colors.black;
  static const appBarIconDark = Colors.white;

  // Bottom bar icons
  // Light theme
  static const bottomBarIconLight = Color(0xFF6F788D); // inactive
  static const bottomBarIconActiveLight = Color(0xFF041844); // active
  // Dark theme
  static const bottomBarIconDark = Color(0xFF698AD0); // inactive
  static const bottomBarIconActiveDark = Color(0xFFFFFFFF); // active

  // Settings menu icons and arrows
  // Light theme
  static const settingsIconLight = Color(0xFF6F788D);
  static const settingsArrowLight = Color(0xFF6F788D);
  // Dark theme
  static const settingsIconDark = Color(0xFF698AD0);
  static const settingsArrowDark = Color(0xFFFFFFFF);

  // Drawer icons
  // Light theme
  static const drawerIconLight = Color(0xFF6F788D);
  // Dark theme
  static const drawerIconDark = Color(0xFFFFFFFF);

  // Misc
  static const enableShadow = true;
}
