import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

Color getColorFromIndex(BuildContext context, int index) {
  switch (index) {
    case 0:
      return context.colors.green;
    case 1:
      return context.colors.yellow;
    case 2:
      return context.colors.blue;
    case 3:
      return context.colors.orange;
    case 4:
      return context.colors.purple;
    case 5:
      return context.colors.red;
    default:
      return context.colors.yellow;
  }
}
