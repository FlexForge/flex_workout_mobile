import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/icon_text_display.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_filter_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/exercise_list_tile.dart';
import 'package:flex_workout_mobile/features/exercise/ui/extensions/list_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exerciseListControllerProvider).toMap();

    final muscleGroupFilters = ref.watch(muscleGroupFilterControllerProvider);
    final equipmentFilters = ref.watch(equipmentFilterControllerProvider);
    final movementPatternFilters =
        ref.watch(movementPatternFilterControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (muscleGroupFilters.isNotEmpty ||
            equipmentFilters.isNotEmpty ||
            movementPatternFilters.isNotEmpty) ...[
          const SizedBox(height: AppLayout.p3),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: AppLayout.p4),
                FlexButton(
                  onPressed: () {
                    ref
                        .read(muscleGroupFilterControllerProvider.notifier)
                        .clear();
                    ref
                        .read(equipmentFilterControllerProvider.notifier)
                        .clear();
                    ref
                        .read(movementPatternFilterControllerProvider.notifier)
                        .clear();
                  },
                  label: 'Clear',
                  labelStyle: context.typography.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  icon: Symbols.close,
                  iconSize: 18,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppLayout.p3,
                    vertical: AppLayout.p1,
                  ),
                  backgroundColor: context.colors.backgroundSecondary,
                  borderColor: context.colors.backgroundSecondary,
                ),
                const SizedBox(width: AppLayout.p2),
                if (muscleGroupFilters.isNotEmpty) ...[
                  IconTextDisplay(
                    label: muscleGroupFilters
                        .map((group) => group.name)
                        .join(', '),
                    icon: Symbols.workspaces,
                  ),
                  const SizedBox(width: AppLayout.p2),
                ],
                if (equipmentFilters.isNotEmpty) ...[
                  IconTextDisplay(
                    label: equipmentFilters
                        .map((group) => group.readableName)
                        .join(', '),
                    icon: Symbols.exercise,
                  ),
                  const SizedBox(width: AppLayout.p2),
                ],
                if (movementPatternFilters.isNotEmpty)
                  IconTextDisplay(
                    label: movementPatternFilters
                        .map((group) => group.readableName)
                        .join(', '),
                    icon: Symbols.directions_run,
                  ),
                const SizedBox(width: AppLayout.p4),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppLayout.p6),
        if (exercises.isEmpty)
          Center(
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
          )
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final section = exercises.entries.toList()[index];

              return Section(
                header: section.key,
                padding: const EdgeInsets.only(
                  left: AppLayout.p4,
                  right: AppLayout.p4,
                ),
                body: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: section.value.length,
                  itemBuilder: (context, index) {
                    final exercise = section.value[index];

                    return ExerciseListTile(
                      exercise: exercise,
                      onTap: () => context.goNamed(
                        ExerciseViewScreen.routeName,
                        pathParameters: {
                          'eid': exercise.id.toString(),
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 54,
                      height: 0,
                      color: context.colors.divider,
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppLayout.p6),
          ),
      ],
    );
  }
}
