import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';

class WorkoutMuscleGroups extends StatelessWidget {
  const WorkoutMuscleGroups({
    required this.workout,
    super.key,
  });

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    final primaryMuscleGroups = workout.primaryMuscleGroups;
    final secondaryMuscleGroups = workout.secondaryMuscleGroups;

    return Section(
      subHeader: 'Muscle Groups Targeted',
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      body: primaryMuscleGroups.isNotEmpty
          ? MuscleGroupView(
              primaryMuscleGroups: primaryMuscleGroups,
              secondaryMuscleGroups: secondaryMuscleGroups,
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
    );
  }
}
