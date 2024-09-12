import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutSummaryOverview extends ConsumerWidget {
  const WorkoutSummaryOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(liveWorkoutControllerProvider);

    return Column(
      children: [
        Section(
          header: 'Overview',
          subHeader: workout.primaryMuscleGroups.isNotEmpty
              ? 'Muscle Groups Targeted'
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          body: workout.primaryMuscleGroups.isNotEmpty
              ? MuscleGroupView(
                  primaryMuscleGroups: workout.primaryMuscleGroups,
                  secondaryMuscleGroups: workout.secondaryMuscleGroups,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                  child: Center(
                    child: Text(
                      'No muscles targeted',
                      style: context.typography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
