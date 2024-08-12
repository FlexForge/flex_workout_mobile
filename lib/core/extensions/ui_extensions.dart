import 'package:flex_workout_mobile/core/theme/app_colors_extension.dart';
import 'package:flex_workout_mobile/core/theme/app_typography_extension.dart';
import 'package:flex_workout_mobile/core/theme/theme.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  AppColorsExtension get colors => Theme.of(this).appColors;
  AppTextThemeExtension get typography => Theme.of(this).appTextTheme;
  ThemeData get theme => Theme.of(this);
  Size get screenSize => MediaQuery.of(this).size;
}
