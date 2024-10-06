import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flutter/material.dart';

class ExerciseOverview extends StatelessWidget {
  const ExerciseOverview({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: Section(
        header: 'Overview',
        subHeader: exercise.primaryMuscleGroups.isNotEmpty
            ? 'Muscle Groups Targeted'
            : null,
        body: exercise.primaryMuscleGroups.isNotEmpty
            ? MuscleGroupView(
                primaryMuscleGroups: exercise.primaryMuscleGroups,
                secondaryMuscleGroups: exercise.secondaryMuscleGroups,
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
    );
  }
}
