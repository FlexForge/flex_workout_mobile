import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class SegmentedController extends StatelessWidget {
  const SegmentedController({
    required this.selectedValue,
    required this.onValueChanged,
    required this.items,
    this.initialValue = 0,
    this.padding = AppLayout.p4,
    this.stretch = false,
    this.borderRadius = AppLayout.cornerRadius,
    this.backgroundColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.foregroundSelectedColor,
    this.foregroundUnselectedColor,
    this.textStyle,
    this.height,
    super.key,
  });

  final int selectedValue;
  final ValueChanged<int> onValueChanged;
  final List<String> items;
  final int? initialValue;
  final bool stretch;

  final Color? thumbColor;
  final Color? thumbBorderColor;
  final Color? backgroundColor;
  final Color? foregroundSelectedColor;
  final Color? foregroundUnselectedColor;

  final TextStyle? textStyle;

  final double? height;
  final double padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: initialValue ?? 0,
      height: height ?? 44,
      children: {
        for (var i = 0; i < items.length; i++)
          i: Text(
            items[i],
            style: (textStyle ?? context.typography.labelLarge).copyWith(
              fontWeight: FontWeight.w500,
              color: i == selectedValue
                  ? (foregroundSelectedColor ??
                      context.colors.backgroundPrimary)
                  : (foregroundUnselectedColor ??
                      context.colors.foregroundPrimary),
            ),
          ),
      },
      padding: padding,
      innerPadding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      thumbDecoration: BoxDecoration(
        color: thumbColor ?? context.colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(borderRadius),
        border: thumbBorderColor != null
            ? Border.all(color: thumbBorderColor!)
            : null,
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      onValueChanged: onValueChanged,
      isStretch: stretch,
      customSegmentSettings:
          // ignore: avoid_redundant_argument_values
          CustomSegmentSettings(splashColor: Colors.transparent),
    );
  }
}
