import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/current_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTrackerAppBar extends ConsumerWidget {
  const MainTrackerAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(currentWorkoutControllerProvider);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppLayout.p4,
        right: AppLayout.p4,
        bottom: AppLayout.p2,
      ),
      child: Row(
        children: [
          Text(
            workout.subtitle,
            style: context.typography.labelMedium.copyWith(
              color: context.colors.foregroundSecondary,
            ),
          ),
          const Spacer(),
          Text(
            workout.startTimestamp.toReadableDate(),
            style: context.typography.labelMedium.copyWith(
              color: context.colors.foregroundSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
