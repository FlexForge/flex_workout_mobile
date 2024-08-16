import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class ProgramOverview extends StatelessWidget {
  const ProgramOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.backgroundSecondary,
      padding: const EdgeInsets.only(
        top: AppLayout.p2,
        bottom: AppLayout.p4,
        left: AppLayout.p4,
        right: AppLayout.p4,
      ),
      child: Column(
        children: [
          Text(
            '(^-^*)',
            style: context.typography.headlineLarge.copyWith(
              fontSize: 64,
              fontWeight: FontWeight.w600,
              color: context.colors.foregroundTertiary,
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          Text(
            'Uh oh looks like your not running a program',
            style: context.typography.bodyMedium
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            'Browse our selection to find one that works for you',
            style: context.typography.bodySmall.copyWith(
              color: context.colors.foregroundSecondary,
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          LargeButton(
            onPressed: () => {},
            label: 'Find a program',
            foregroundColor: context.colors.backgroundPrimary,
            backgroundColor: context.colors.foregroundPrimary,
            expanded: true,
          ),
          const SizedBox(height: AppLayout.p2),
          LargeButton(
            onPressed: () {},
            label: 'Start Empty Workout',
            expanded: true,
          ),
        ],
      ),
    );
  }
}
