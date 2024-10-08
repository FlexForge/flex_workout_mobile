import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class IconTextDisplay extends StatelessWidget {
  const IconTextDisplay({required this.label, required this.icon, super.key});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.divider,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppLayout.cornerRadius)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppLayout.p3,
        vertical: AppLayout.p1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: AppLayout.p1),
          Text(
            label,
            style: context.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
