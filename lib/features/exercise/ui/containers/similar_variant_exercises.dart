import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/similar_exercise_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/exercise_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarVariantExercises extends ConsumerWidget {
  const SimilarVariantExercises({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarExercises =
        ref.watch(similarExerciseControllerProvider(exercise));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: Section(
        header: 'Similar & Variant Exercises',
        subHeader: 'Similar Exercises',
        body: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final similarExercise = similarExercises[index];
            return ExerciseListTile(exercise: similarExercise, onTap: () {});
          },
          separatorBuilder: (context, index) =>
              Divider(height: 1, indent: 54, color: context.colors.divider),
          itemCount: similarExercises.length,
        ),
      ),
    );
  }
}
