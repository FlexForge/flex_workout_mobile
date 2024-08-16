import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
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
        subHeader: 'Muscle Groups Targeted',
        body: MuscleGroupView(
          primaryMuscleGroups: exercise.primaryMuscleGroups,
          secondaryMuscleGroups: exercise.secondaryMuscleGroups,
        ),
      ),
    );
  }
}
