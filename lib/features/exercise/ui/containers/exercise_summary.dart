import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_alert_dialog.dart';
import 'package:flex_workout_mobile/core/common/ui/components/icon_text_display.dart';
import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_delete_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseSummary extends ConsumerWidget {
  const ExerciseSummary({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onDelete() {
      ref.read(exerciseDeleteControllerProvider(exercise).notifier).handle();
      context
        ..pop()
        ..pop();
    }

    return Container(
      color: context.colors.backgroundSecondary,
      padding: const EdgeInsets.only(top: AppLayout.p2, bottom: AppLayout.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StackedText(
                        heading: exercise.movementPattern.readableName,
                        subHeading: 'Movement Pattern',
                        alignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppLayout.p4),
                Row(
                  children: [
                    SquareButton(
                      onPressed: () => context.pushNamed(
                        ExerciseEditScreen.routeName,
                        pathParameters: {'eid': exercise.id.toString()},
                      ),
                      label: 'Edit',
                      icon: Symbols.edit,
                      iconSize: 24,
                    ),
                    const SizedBox(width: AppLayout.p4),
                    SquareButton(
                      onPressed: () async => showFlexAlertDialog(
                        context,
                        title: 'Delete Exercise',
                        description:
                            'Are you sure you want to delete ${exercise.name}? '
                            'This action cannot be undone.',
                        onPressed: onDelete,
                      ),
                      label: 'Delete',
                      icon: Symbols.delete_outline,
                      iconSize: 24,
                    ),
                    const SizedBox(width: AppLayout.p4),
                    SquareButton(
                      onPressed: () => {},
                      label: 'Demo',
                      icon: Symbols.movie,
                      iconSize: 24,
                    ),
                  ],
                ),
                const SizedBox(height: AppLayout.p4),
                Divider(
                  color: context.colors.divider,
                  height: 0,
                ),
                if (exercise.description != null &&
                    exercise.description!.isNotEmpty) ...[
                  const SizedBox(height: AppLayout.p4),
                  Text(
                    exercise.description!,
                    style: context.typography.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: AppLayout.p4),
                IconTextDisplay(
                  label: exercise.equipment.readableName,
                  icon: Symbols.exercise,
                ),
                const SizedBox(width: AppLayout.p3),
                IconTextDisplay(
                  label: exercise.engagement.readableName,
                  icon: Symbols.keyboard_double_arrow_up,
                ),
                const SizedBox(width: AppLayout.p4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
