import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';

class WorkoutListTile extends StatelessWidget {
  const WorkoutListTile({
    required this.workout,
    required this.onTap,
    this.suffix,
    super.key,
  });

  final WorkoutModel workout;
  final VoidCallback onTap;

  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: onTap,
      title: Text(
        workout.title,
        style: context.typography.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      suffix: suffix,
    );
  }
}
