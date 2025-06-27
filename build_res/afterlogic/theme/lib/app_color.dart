import 'dart:ui';

class AppColor {
  static const _color = const Color(0xFF009FFF);
  static const primary = _color;
  static const primaryVariant = _color;

  static const secondary = _color;
  static const secondaryVariant = _color;

  static const accent = _color;
  static const accentVariant = _color;

  static const surface = Color(0xFFFFFFFF);

  static const appBarBackground = Color(0xFFF4F1FD);
  static const bottomNavigationBackground =
      Color(0xFFF4F1FD); // color for bottom navigation

  // Цвета для bottom bar иконок
  // Светлая тема
  static const bottomBarIconLight = Color(0xFF6F788D); // неактивные иконки
  static const bottomBarIconActiveLight = Color(0xFF041844); // активные иконки

  // Темная тема
  static const bottomBarIconDark = Color(0xFF698AD0); // неактивные иконки
  static const bottomBarIconActiveDark = Color(0xFFFFFFFF); // активные иконки

  // Цвета для settings menu иконок и стрелок
  // Светлая тема
  static const settingsIconLight = Color(0xFF6F788D); // иконки в светлой теме
  static const settingsArrowLight = Color(0xFF6F788D); // стрелки в светлой теме

  // Темная тема
  static const settingsIconDark = Color(0xFF698AD0); // иконки в темной теме
  static const settingsArrowDark = Color(0xFFFFFFFF); // стрелки в темной теме

  // Цвета для drawer иконок
  // Светлая тема
  static const drawerIconLight =
      Color(0xFF6F788D); // иконки drawer в светлой теме

  // Темная тема
  static const drawerIconDark =
      Color(0xFFFFFFFF); // иконки drawer в темной теме

  static const warning = Color(0xFFF44336);
  static const enableShadow = true;

  // AppBar divider color (only used when useAppBarDivider is enabled)
  static const appBarDivider = Color(0xFFEBEBEB);

  // Цвета для звёзд в mail (дефолтные)
  static const starActive = Color(0xFFFFC107); // дефолтная активная звезда
  static const starInactiveLight =
      Color(0xFFB0B0B0); // неактивная звезда в светлой теме
  static const starInactiveDark =
      Color(0xFF808080); // неактивная звезда в тёмной теме

  // Цвета для полей ввода (для совместимости)
  static const inputBackground = Color(0xFFF5F5F5); // стандартный фон инпутов
  static const inputBorder = Color(0xFFE0E0E0); // стандартная граница инпутов
  static const inputPlaceholder = Color(0xFF757575); // стандартный placeholder

  // Цвета для секций и групп инпутов (для совместимости)
  static const sectionBackground = Color(0xFFF5F5F5); // фон для секций
  static const sectionText = Color(0xFF212121); // текст секций
  static const inputGroupBackground =
      Color(0xFFF5F5F5); // фон для группы инпутов
  static const inputGroupBorder =
      Color(0xFFE0E0E0); // граница для группы инпутов

  // Цвета для текста (для совместимости)
  static const appBarText = Color(0xFF212121); // текст в appbar
  static const contactsPrimary =
      Color(0xFF212121); // основной цвет текста контактов
}
