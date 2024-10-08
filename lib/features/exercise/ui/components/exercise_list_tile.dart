import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({
    required this.exercise,
    required this.onTap,
    this.suffix,
    super.key,
  });

  final ExerciseModel exercise;
  final VoidCallback onTap;

  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: onTap,
      title: Text(
        exercise.name,
        style: context.typography.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            exercise.movementPattern.readableName,
            style: context.typography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
          const SizedBox(width: AppLayout.p4),
          Flexible(
            child: Text(
              exercise.primaryMuscleGroups.map((e) => e.name).join(' • '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typography.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundSecondary,
              ),
            ),
          ),
        ],
      ),
      suffix: suffix,
    );
  }
}
