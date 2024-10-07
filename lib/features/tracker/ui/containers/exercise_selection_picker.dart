import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/search_bar.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/debouncer.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_quick_create.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_filter_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_search_query_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/exercise_selection_filters.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/exercise_selection_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseSelectionPicker extends ConsumerStatefulWidget {
  const ExerciseSelectionPicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseSelectionPickerState();
}

class _ExerciseSelectionPickerState
    extends ConsumerState<ExerciseSelectionPicker> {
  final List<ExerciseModel> items = [];
  final debouncer = Debouncer(milliseconds: 250);

  void updateSelectedItems(ExerciseModel exercise) {
    setState(() {
      if (items.contains(exercise)) {
        items.remove(exercise);
      } else {
        items.add(exercise);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections =
        ref.watch(exerciseSelectionListControllerProvider).toSelectionMap();

    final muscleGroupFilters = ref.watch(muscleGroupFilterControllerProvider);
    final equipmentFilters = ref.watch(equipmentFilterControllerProvider);
    final movementPatternFilters =
        ref.watch(movementPatternFilterControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppLayout.p4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Row(
            children: [
              Expanded(
                child: FlexSearchBar(
                  onChanged: (value) => debouncer.run(
                    () => ref
                        .read(
                          exerciseSelectionSearchQueryControllerProvider
                              .notifier,
                        )
                        .handle(value),
                  ),
                  hintText: 'Search...',
                  prefixIcon: Symbols.search,
                  suffix: FlexButton(
                    onPressed: () =>
                        context.goNamed(ExerciseSelectionFilters.routeName),
                    icon: Symbols.sort,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () async {
                  final res = await context
                      .pushNamed<ExerciseModel>(ExerciseQuickCreate.routeName);

                  if (res == null) return;
                  items.add(res);
                  ref
                      .read(liveWorkoutControllerProvider.notifier)
                      .addNewExercise(res);
                },
                icon: Icons.add,
                backgroundColor: context.colors.backgroundSecondary,
                foregroundColor: context.colors.foregroundPrimary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.p4),
        if (muscleGroupFilters.isNotEmpty ||
            equipmentFilters.isNotEmpty ||
            movementPatternFilters.isNotEmpty) ...[
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
                    muscleGroupFilters.map((group) => group.name).join(', '),
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
        Expanded(
          child: ListView.separated(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections.entries.toList()[index];

              return Section(
                header: section.key,
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                body: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: section.value.length,
                  itemBuilder: (context, index) {
                    final exercise = section.value[index];

                    return FlexListTile(
                      onTap: () => updateSelectedItems(exercise),
                      title: Text(
                        exercise.name,
                        style: context.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: rowSubtitle(context, exercise),
                      suffix: items.contains(exercise)
                          ? CircleAvatar(
                              radius: 10,
                              backgroundColor: context.colors.foregroundPrimary,
                              child: Center(
                                child: Text(
                                  (items.indexOf(exercise) + 1).toString(),
                                  style:
                                      context.typography.labelXSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: context.colors.backgroundPrimary,
                                  ),
                                ),
                              ),
                            )
                          : const Icon(
                              Symbols.check_circle_filled_rounded,
                              size: 20,
                            ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 54,
                    height: 0,
                    color: context.colors.divider,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppLayout.p6),
          ),
        ),
        ExerciseSelectionBottomBar(items: items),
      ],
    );
  }
}

Widget rowSubtitle(BuildContext context, ExerciseModel exercise) {
  return Row(
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
