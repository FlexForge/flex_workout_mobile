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
    this.small = false,
    this.stretch = false,
    this.backgroundColor,
    super.key,
  });

  final int selectedValue;
  final ValueChanged<int> onValueChanged;
  final List<String> items;
  final int? initialValue;
  final bool small;
  final bool stretch;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: initialValue ?? 0,
      height: small ? 32 : 44,
      children: {
        for (var i = 0; i < items.length; i++)
          i: Text(
            items[i],
            style: small
                ? context.typography.labelSmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: i == selectedValue
                        ? context.colors.backgroundPrimary
                        : context.colors.foregroundPrimary,
                  )
                : context.typography.labelLarge.copyWith(
                    color: i == selectedValue
                        ? context.colors.backgroundPrimary
                        : context.colors.foregroundPrimary,
                  ),
          ),
      },
      padding: small ? AppLayout.p3 : AppLayout.p4,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
      ),
      thumbDecoration: BoxDecoration(
        color: context.colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
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
