import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/analytics/controllers/exercise_history_controller.dart';
import 'package:flex_workout_mobile/features/analytics/data/models/line_graph_model.dart';
import 'package:flex_workout_mobile/features/analytics/ui/containers/exercise_history_tile.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseRecordsProgress extends ConsumerWidget {
  const ExerciseRecordsProgress({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxLoadTile =
        ref.watch(exerciseMaxLoadControllerProvider(exercise.id.toString()));
    final oneRmTile =
        ref.watch(exerciseOneRmControllerProvider(exercise.id.toString()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Text(
            'Insights & Analytics',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: context.typography.headlineMedium
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppLayout.p3),
        LayoutGrid(
          columnSizes: [1.fr, 1.fr],
          rowSizes: const [auto],
          children: [
            ExerciseHistoryTile(
              padding: const EdgeInsets.only(
                left: AppLayout.p4,
                right: AppLayout.p3 / 2,
              ),
              graphColor: context.colors.blue,
              graph: oneRmTile.isNotEmpty
                  ? LineGraphModel(name: '1 RM', points: oneRmTile)
                  : null,
            ),
            ExerciseHistoryTile(
              padding: const EdgeInsets.only(
                right: AppLayout.p4,
                left: AppLayout.p3 / 2,
              ),
              graphColor: context.colors.yellow,
              graph: maxLoadTile.isNotEmpty
                  ? LineGraphModel(name: 'Max Load', points: maxLoadTile)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
