import 'package:flex_workout_mobile/core/theme/app_colors.dart';
import 'package:flex_workout_mobile/core/theme/app_colors_extension.dart';
import 'package:flex_workout_mobile/core/theme/app_typography.dart';
import 'package:flex_workout_mobile/core/theme/app_typography_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final _textTheme = AppTextThemeExtension(
    titleLarge: AppTypography.title.large,
    titleMedium: AppTypography.title.medium,
    titleSmall: AppTypography.title.small,
    headlineLarge: AppTypography.headline.large,
    headlineMedium: AppTypography.headline.medium,
    headlineSmall: AppTypography.headline.small,
    bodyLarge: AppTypography.body.large,
    bodyMedium: AppTypography.body.medium,
    bodySmall: AppTypography.body.small,
    labelLarge: AppTypography.label.large,
    labelMedium: AppTypography.label.medium,
    labelSmall: AppTypography.label.small,
    labelXSmall: AppTypography.label.xSmall,
  );

  static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      extensions: [_lightAppColors, _textTheme],
    );
  }();

  static final _lightAppColors = AppColorsExtension(
    primary: const Color(0xff6200ee),
    onPrimary: Colors.white,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffb00020),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    backgroundPrimary: AppColors.lightModeColors.backgroundPrimary,
    backgroundSecondary: AppColors.lightModeColors.backgroundSecondary,
    backgroundTertiary: AppColors.lightModeColors.backgroundTertiary,
    backgroundQuaternary: AppColors.lightModeColors.backgroundQuaternary,
    foregroundPrimary: AppColors.lightModeColors.foregroundPrimary,
    foregroundSecondary: AppColors.lightModeColors.foregroundSecondary,
    foregroundTertiary: AppColors.lightModeColors.foregroundTertiary,
    foregroundQuaternary: AppColors.lightModeColors.foregroundQuaternary,
    divider: AppColors.lightModeColors.divider,
    overlay: AppColors.lightModeColors.overlay,
    pink: AppColors.lightModeColors.pink,
    purple: AppColors.lightModeColors.purple,
    blue: AppColors.lightModeColors.blue,
    green: AppColors.lightModeColors.green,
    yellow: AppColors.lightModeColors.yellow,
    orange: AppColors.lightModeColors.orange,
    red: AppColors.lightModeColors.red,
    teal: AppColors.lightModeColors.teal,
    cyan: AppColors.lightModeColors.cyan,
    lime: AppColors.lightModeColors.lime,
    indigo: AppColors.lightModeColors.indigo,
    magenta: AppColors.lightModeColors.magenta,
    amber: AppColors.lightModeColors.amber,
  );

  static final dark = ThemeData.dark().copyWith(
    extensions: [_darkAppColors, _textTheme],
  );

  static final _darkAppColors = AppColorsExtension(
    primary: const Color(0xffbb86fc),
    onPrimary: Colors.black,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffcf6679),
    onError: Colors.black,
    background: const Color(0xff121212),
    onBackground: Colors.white,
    surface: const Color(0xff121212),
    onSurface: Colors.white,
    backgroundPrimary: AppColors.darkModeColors.backgroundPrimary,
    backgroundSecondary: AppColors.darkModeColors.backgroundSecondary,
    backgroundTertiary: AppColors.darkModeColors.backgroundTertiary,
    backgroundQuaternary: AppColors.darkModeColors.backgroundQuaternary,
    foregroundPrimary: AppColors.darkModeColors.foregroundPrimary,
    foregroundSecondary: AppColors.darkModeColors.foregroundSecondary,
    foregroundTertiary: AppColors.darkModeColors.foregroundTertiary,
    foregroundQuaternary: AppColors.darkModeColors.foregroundQuaternary,
    divider: AppColors.darkModeColors.divider,
    overlay: AppColors.darkModeColors.overlay,
    pink: AppColors.darkModeColors.pink,
    purple: AppColors.darkModeColors.purple,
    blue: AppColors.darkModeColors.blue,
    green: AppColors.darkModeColors.green,
    yellow: AppColors.darkModeColors.yellow,
    orange: AppColors.darkModeColors.orange,
    red: AppColors.darkModeColors.red,
    teal: AppColors.darkModeColors.teal,
    cyan: AppColors.darkModeColors.cyan,
    lime: AppColors.darkModeColors.lime,
    indigo: AppColors.darkModeColors.indigo,
    magenta: AppColors.darkModeColors.magenta,
    amber: AppColors.darkModeColors.amber,
  );
}

extension AppThemeExtension on ThemeData {
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppTheme._darkAppColors;

  AppTextThemeExtension get appTextTheme =>
      extension<AppTextThemeExtension>() ?? AppTheme._textTheme;
}
