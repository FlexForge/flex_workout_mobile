import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseSummary extends StatelessWidget {
  const ExerciseSummary({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.backgroundSecondary,
      padding: const EdgeInsets.only(top: AppLayout.p2, bottom: AppLayout.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Column(
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
                      onPressed: () => {},
                      label: 'Edit',
                      icon: Symbols.edit,
                      iconSize: 24,
                    ),
                    const SizedBox(width: AppLayout.p4),
                    SquareButton(
                      onPressed: () => {},
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
                extraInfo(
                  context,
                  exercise.equipment.readableName,
                  Symbols.exercise,
                ),
                const SizedBox(width: AppLayout.p4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget extraInfo(BuildContext context, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.divider,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppLayout.cornerRadius)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppLayout.p3,
        vertical: AppLayout.p1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: AppLayout.p1),
          Text(
            label,
            style: context.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
