import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Visual description of the sign-in form: the card that wraps the inputs and
/// the input fields themselves.
///
/// Kept as a [ThemeExtension] separate from the app-wide
/// [ThemeData.inputDecorationTheme] and [ColorScheme] so a brand can restyle
/// the login screen (border, shadow, padding, field colors, ...) by editing
/// only its `app_theme.dart`, without affecting forms elsewhere in the app.
@immutable
class LoginFormStyle extends ThemeExtension<LoginFormStyle> {
  // --- The whole sign-in screen ---

  /// Background painted behind the entire sign-in screen: a flat color,
  /// a gradient or an image. Consumed by `LoginGradient`.
  final Decoration screenBackground;

  // --- The block (card) around the fields ---

  /// Gap between the card and the screen edges.
  final EdgeInsets cardMargin;

  /// Padding between the card border and its content.
  final EdgeInsets cardPadding;

  /// Maximum width the card is allowed to grow to.
  final double cardMaxWidth;

  /// Background, border, corner radius and shadow of the card.
  final BoxDecoration cardDecoration;

  // --- Header ---

  /// Style of the "Sign in" title above the fields.
  final TextStyle titleTextStyle;

  // --- Input fields ---

  final Color fieldFillColor;
  final EdgeInsets fieldContentPadding;
  final double fieldRadius;
  final Color fieldBorderColor;
  final Color fieldFocusedBorderColor;
  final Color fieldErrorBorderColor;
  final TextStyle fieldTextStyle;
  final TextStyle fieldHintStyle;
  final Color? fieldCursorColor;
  final Color? visibilityToggleColor;

  const LoginFormStyle({
    required this.screenBackground,
    required this.cardMargin,
    required this.cardPadding,
    required this.cardMaxWidth,
    required this.cardDecoration,
    required this.titleTextStyle,
    required this.fieldFillColor,
    required this.fieldContentPadding,
    required this.fieldRadius,
    required this.fieldBorderColor,
    required this.fieldFocusedBorderColor,
    required this.fieldErrorBorderColor,
    required this.fieldTextStyle,
    required this.fieldHintStyle,
    this.fieldCursorColor,
    this.visibilityToggleColor,
  });

  /// Used when a brand's [ThemeData] does not register the extension, so
  /// widgets never have to null-check. Mirrors the historical hard-coded look.
  static const fallback = LoginFormStyle(
    screenBackground: BoxDecoration(color: Color(0xFFFFFFFF)),
    cardMargin: EdgeInsets.symmetric(horizontal: 22.0),
    cardPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 36.0),
    cardMaxWidth: 450.0,
    cardDecoration: BoxDecoration(),
    titleTextStyle: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    fieldFillColor: Color(0x80FFFFFF),
    fieldContentPadding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    fieldRadius: 10.0,
    fieldBorderColor: Color(0xFFEBEBEB),
    fieldFocusedBorderColor: Color(0xFF1D67CD),
    fieldErrorBorderColor: Color(0xFFF44336),
    fieldTextStyle: TextStyle(color: Colors.black87),
    fieldHintStyle: TextStyle(color: Color(0xFFA6ACB8)),
  );

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(color: color),
      );

  /// Field styling packaged as an [InputDecorationTheme] so it can also be
  /// applied to a [Theme] scoped to the sign-in screens if desired.
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: fieldFillColor,
        contentPadding: fieldContentPadding,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: fieldHintStyle,
        border: _border(fieldBorderColor),
        enabledBorder: _border(fieldBorderColor),
        focusedBorder: _border(fieldFocusedBorderColor),
        errorBorder: _border(fieldErrorBorderColor),
        focusedErrorBorder: _border(fieldErrorBorderColor),
      );

  @override
  LoginFormStyle copyWith({
    Decoration? screenBackground,
    EdgeInsets? cardMargin,
    EdgeInsets? cardPadding,
    double? cardMaxWidth,
    BoxDecoration? cardDecoration,
    TextStyle? titleTextStyle,
    Color? fieldFillColor,
    EdgeInsets? fieldContentPadding,
    double? fieldRadius,
    Color? fieldBorderColor,
    Color? fieldFocusedBorderColor,
    Color? fieldErrorBorderColor,
    TextStyle? fieldTextStyle,
    TextStyle? fieldHintStyle,
    Color? fieldCursorColor,
    Color? visibilityToggleColor,
  }) {
    return LoginFormStyle(
      screenBackground: screenBackground ?? this.screenBackground,
      cardMargin: cardMargin ?? this.cardMargin,
      cardPadding: cardPadding ?? this.cardPadding,
      cardMaxWidth: cardMaxWidth ?? this.cardMaxWidth,
      cardDecoration: cardDecoration ?? this.cardDecoration,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      fieldFillColor: fieldFillColor ?? this.fieldFillColor,
      fieldContentPadding: fieldContentPadding ?? this.fieldContentPadding,
      fieldRadius: fieldRadius ?? this.fieldRadius,
      fieldBorderColor: fieldBorderColor ?? this.fieldBorderColor,
      fieldFocusedBorderColor:
          fieldFocusedBorderColor ?? this.fieldFocusedBorderColor,
      fieldErrorBorderColor:
          fieldErrorBorderColor ?? this.fieldErrorBorderColor,
      fieldTextStyle: fieldTextStyle ?? this.fieldTextStyle,
      fieldHintStyle: fieldHintStyle ?? this.fieldHintStyle,
      fieldCursorColor: fieldCursorColor ?? this.fieldCursorColor,
      visibilityToggleColor:
          visibilityToggleColor ?? this.visibilityToggleColor,
    );
  }

  @override
  LoginFormStyle lerp(ThemeExtension<LoginFormStyle>? other, double t) {
    if (other is! LoginFormStyle) return this;
    return LoginFormStyle(
      screenBackground:
          Decoration.lerp(screenBackground, other.screenBackground, t) ??
              (t < 0.5 ? screenBackground : other.screenBackground),
      cardMargin: EdgeInsets.lerp(cardMargin, other.cardMargin, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
      cardMaxWidth: lerpDouble(cardMaxWidth, other.cardMaxWidth, t)!,
      cardDecoration:
          BoxDecoration.lerp(cardDecoration, other.cardDecoration, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      fieldFillColor: Color.lerp(fieldFillColor, other.fieldFillColor, t)!,
      fieldContentPadding:
          EdgeInsets.lerp(fieldContentPadding, other.fieldContentPadding, t)!,
      fieldRadius: lerpDouble(fieldRadius, other.fieldRadius, t)!,
      fieldBorderColor:
          Color.lerp(fieldBorderColor, other.fieldBorderColor, t)!,
      fieldFocusedBorderColor: Color.lerp(
          fieldFocusedBorderColor, other.fieldFocusedBorderColor, t)!,
      fieldErrorBorderColor:
          Color.lerp(fieldErrorBorderColor, other.fieldErrorBorderColor, t)!,
      fieldTextStyle: TextStyle.lerp(fieldTextStyle, other.fieldTextStyle, t)!,
      fieldHintStyle: TextStyle.lerp(fieldHintStyle, other.fieldHintStyle, t)!,
      fieldCursorColor:
          Color.lerp(fieldCursorColor, other.fieldCursorColor, t),
      visibilityToggleColor:
          Color.lerp(visibilityToggleColor, other.visibilityToggleColor, t),
    );
  }
}
