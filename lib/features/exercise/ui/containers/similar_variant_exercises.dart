import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/similar_exercise_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/variant_exercise_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/exercise_list_tile.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SimilarVariantExercises extends ConsumerWidget {
  const SimilarVariantExercises({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarExercises =
        ref.watch(similarExerciseControllerProvider(exercise));
    final variantExercises =
        ref.watch(variantExerciseControllerProvider(exercise));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: Column(
        children: [
          Section(
            header: 'Similar & Variant Exercises',
            subHeader: similarExercises.isNotEmpty ? 'Similar Exercises' : null,
            body: similarExercises.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final similarExercise = similarExercises[index];
                      return ExerciseListTile(
                        exercise: similarExercise,
                        onTap: () => context.pushNamed(
                          ExerciseViewScreen.routeName,
                          pathParameters: {
                            'eid': similarExercise.id.toString(),
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      indent: 54,
                      color: context.colors.divider,
                    ),
                    itemCount: similarExercises.length,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                    child: Center(
                      child: Text(
                        'No similar exercises',
                        style: context.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: AppLayout.p3),
          Section(
            subHeader: variantExercises.isNotEmpty ? 'Variant Exercises' : null,
            body: variantExercises.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final variantExercise = variantExercises[index];
                      return ExerciseListTile(
                        exercise: variantExercise,
                        onTap: () => context.pushNamed(
                          ExerciseViewScreen.routeName,
                          pathParameters: {
                            'eid': variantExercise.id.toString(),
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      indent: 54,
                      color: context.colors.divider,
                    ),
                    itemCount: variantExercises.length,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                    child: Center(
                      child: Text(
                        'No variant exercises',
                        style: context.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
