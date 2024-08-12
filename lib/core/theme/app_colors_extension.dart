import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,

    /// Extension colors for the app.
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundQuaternary,
    required this.foregroundPrimary,
    required this.foregroundSecondary,
    required this.foregroundTertiary,
    required this.foregroundQuaternary,
    required this.divider,
    required this.overlay,
    required this.pink,
    required this.purple,
    required this.blue,
    required this.green,
    required this.yellow,
    required this.orange,
    required this.red,
    required this.teal,
    required this.cyan,
    required this.lime,
    required this.indigo,
    required this.magenta,
    required this.amber,
  });

  /// Base colors for the app.
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;

  /// Extension colors for the app.
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundQuaternary;
  final Color foregroundPrimary;
  final Color foregroundSecondary;
  final Color foregroundTertiary;
  final Color foregroundQuaternary;
  final Color divider;
  final Color overlay;

  final Color pink;
  final Color purple;
  final Color blue;
  final Color green;
  final Color yellow;
  final Color orange;
  final Color red;
  final Color teal;
  final Color cyan;
  final Color lime;
  final Color indigo;
  final Color magenta;
  final Color amber;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? error,
    Color? onError,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,

    /// Extension colors for the app.
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? backgroundQuaternary,
    Color? foregroundPrimary,
    Color? foregroundSecondary,
    Color? foregroundTertiary,
    Color? foregroundQuaternary,
    Color? divider,
    Color? overlay,
    Color? pink,
    Color? purple,
    Color? blue,
    Color? green,
    Color? yellow,
    Color? orange,
    Color? red,
    Color? teal,
    Color? cyan,
    Color? lime,
    Color? indigo,
    Color? magenta,
    Color? amber,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      backgroundQuaternary: backgroundQuaternary ?? this.backgroundQuaternary,
      foregroundPrimary: foregroundPrimary ?? this.foregroundPrimary,
      foregroundSecondary: foregroundSecondary ?? this.foregroundSecondary,
      foregroundTertiary: foregroundTertiary ?? this.foregroundTertiary,
      foregroundQuaternary: foregroundQuaternary ?? this.foregroundQuaternary,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
      pink: pink ?? this.pink,
      purple: purple ?? this.purple,
      blue: blue ?? this.blue,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      orange: orange ?? this.orange,
      red: red ?? this.red,
      teal: teal ?? this.teal,
      cyan: cyan ?? this.cyan,
      lime: lime ?? this.lime,
      indigo: indigo ?? this.indigo,
      magenta: magenta ?? this.magenta,
      amber: amber ?? this.amber,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      backgroundPrimary:
          Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundTertiary:
          Color.lerp(backgroundTertiary, other.backgroundTertiary, t)!,
      backgroundQuaternary:
          Color.lerp(backgroundQuaternary, other.backgroundQuaternary, t)!,
      foregroundPrimary:
          Color.lerp(foregroundPrimary, other.foregroundPrimary, t)!,
      foregroundSecondary:
          Color.lerp(foregroundSecondary, other.foregroundSecondary, t)!,
      foregroundTertiary:
          Color.lerp(foregroundTertiary, other.foregroundTertiary, t)!,
      foregroundQuaternary:
          Color.lerp(foregroundQuaternary, other.foregroundQuaternary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      green: Color.lerp(green, other.green, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      red: Color.lerp(red, other.red, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      lime: Color.lerp(lime, other.lime, t)!,
      indigo: Color.lerp(indigo, other.indigo, t)!,
      magenta: Color.lerp(magenta, other.magenta, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
    );
  }
}

/// Optional. If you also want to assign colors in the `ColorScheme`.
extension ColorSchemeBuilder on AppColorsExtension {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: error,
      onError: onError,
      surface: surface,
      onSurface: onSurface,
    );
  }
}
