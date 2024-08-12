import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.icon,
    required this.info,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2,
    super.key,
  });

  final IconData icon;
  final String info;

  final Color? backgroundColor;
  final double borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppLayout.p4,
        horizontal: AppLayout.p6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: AppLayout.p6),
          Expanded(
            child: Text(
              info,
              style: context.typography.labelMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
