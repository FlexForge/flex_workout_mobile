import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exerciseListControllerProvider);

    return exercises.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    color: context.colors.foregroundSecondary,
                    size: 48,
                  ),
                  Text(
                    'No Exercises Found',
                    style: context.typography.headlineMedium.copyWith(
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SliverList.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) => Text(exercises[index].name),
          );
  }
}
