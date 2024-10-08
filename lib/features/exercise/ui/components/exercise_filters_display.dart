import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/icon_text_display.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseFiltersDisplay extends ConsumerWidget {
  const ExerciseFiltersDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleGroupFilters = ref.watch(muscleGroupFilterControllerProvider);
    final equipmentFilters = ref.watch(equipmentFilterControllerProvider);
    final movementPatternFilters =
        ref.watch(movementPatternFilterControllerProvider);

    return (muscleGroupFilters.isNotEmpty ||
            equipmentFilters.isNotEmpty ||
            movementPatternFilters.isNotEmpty)
        ? Column(
            children: [
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
                            .read(
                              movementPatternFilterControllerProvider.notifier,
                            )
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
              const SizedBox(height: AppLayout.p4),
            ],
          )
        : const SizedBox.shrink();
  }
}
