import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/utils/svg.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flutter/material.dart';

class MuscleGroupDisplay extends StatelessWidget {
  const MuscleGroupDisplay({
    required this.muscleGroups,
    required this.primaryMuscleGroups,
    required this.secondaryMuscleGroups,
    super.key,
  });

  final List<PathContainer> muscleGroups;

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 238,
      width: 114,
      child: Stack(
        children: [
          for (final muscleGroup in muscleGroups)
            _getClippedImage(
              clipper: Clipper(
                svgPath: muscleGroup.path,
              ),
              color: primaryMuscleGroups.any(
                (primary) =>
                    primary.diagramPathNames.contains(muscleGroup.name),
              )
                  ? context.colors.pink
                  : secondaryMuscleGroups.any(
                      (secondary) =>
                          secondary.diagramPathNames.contains(muscleGroup.name),
                    )
                      ? context.colors.pink.withOpacity(0.3)
                      : context.colors.backgroundTertiary,
              muscleGroup: muscleGroup,
            ),
        ],
      ),
    );
  }

  Widget _getClippedImage({
    required Clipper clipper,
    required Color color,
    required PathContainer muscleGroup,
  }) {
    return ClipPath(
      clipper: clipper,
      child: Container(
        color: color,
      ),
    );
  }
}
