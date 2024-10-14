import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExerciseSelectionBottomBar extends ConsumerWidget {
  const ExerciseSelectionBottomBar({required this.items, super.key});

  final List<ExerciseModel> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addExercise(List<ExerciseModel> exercises) {
      ref.read(workoutControllerProvider.notifier).addDefaultSection(items);
      context.pop();
    }

    void addSuperSet(List<ExerciseModel> exercises) {
      ref.read(workoutControllerProvider.notifier).addSupersetSection(items);
      context.pop();
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.divider), // Top border
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlexButton(
                onPressed: items.length > 1 ? () => addSuperSet(items) : null,
                label: 'Add as Superset',
                backgroundColor: context.colors.backgroundSecondary,
                foregroundColor: context.colors.foregroundPrimary,
              ),
            ),
            const SizedBox(
              width: AppLayout.p2,
            ),
            Expanded(
              child: FlexButton(
                onPressed: () => addExercise(items),
                label: 'Add Exercises'
                    '${items.isNotEmpty ? ' (${items.length})' : ''}',
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
