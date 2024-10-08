import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
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
                      extraInfo(
                        context,
                        muscleGroupFilters
                            .map((group) => group.name)
                            .join(', '),
                        Symbols.workspaces,
                      ),
                      const SizedBox(width: AppLayout.p2),
                    ],
                    if (equipmentFilters.isNotEmpty) ...[
                      extraInfo(
                        context,
                        equipmentFilters
                            .map((group) => group.readableName)
                            .join(', '),
                        Symbols.exercise,
                      ),
                      const SizedBox(width: AppLayout.p2),
                    ],
                    if (movementPatternFilters.isNotEmpty)
                      extraInfo(
                        context,
                        movementPatternFilters
                            .map((group) => group.readableName)
                            .join(', '),
                        Symbols.directions_run,
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
