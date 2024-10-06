import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/muscle_group_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class ExerciseSelectionFiltersModal extends StatelessWidget {
  const ExerciseSelectionFiltersModal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      initialExtent: const Extent.proportional(0.5),
      minExtent: const Extent.proportional(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class ExerciseSelectionFilters extends ConsumerWidget {
  const ExerciseSelectionFilters({super.key});

  static const routePath = 'exercise_selection_filters';
  static const routeName = 'exercise_selection_filters';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleGroups = ref.watch(muscleGroupListControllerProvider);

    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
        child: ListView(
          children: [
            const SizedBox(height: AppLayout.p2),
            Row(
              children: [
                Text(
                  'Filters',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.typography.headlineMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FlexButton(
                  onPressed: context.pop,
                  icon: Symbols.close,
                  iconSize: 16,
                  iconWeight: 700,
                  padding: const EdgeInsets.all(AppLayout.p1),
                  borderRadius: AppLayout.roundedRadius,
                  iconColor: context.colors.foregroundSecondary,
                  backgroundColor: context.colors.backgroundSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppLayout.p4),
            Text(
              'Muscle Groups',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.typography.headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppLayout.p2),
            LayoutGrid(
              columnGap: AppLayout.p2,
              rowGap: AppLayout.p2,
              columnSizes: [1.fr, 1.fr],
              rowSizes: List.generate(10, (_) => auto),
              children: [
                RadioListItem(
                  onPressed: () {
                    ref
                        .read(muscleGroupFilterControllerProvider.notifier)
                        .clear();
                  },
                  selected:
                      ref.watch(muscleGroupFilterControllerProvider).isEmpty,
                  padding: const EdgeInsets.only(right: AppLayout.p1),
                  name: 'All',
                  icon: Symbols.apps,
                  value: null,
                ),
                ...muscleGroups.map(
                  (group) => RadioListItem(
                    onPressed: () {
                      ref
                          .read(muscleGroupFilterControllerProvider.notifier)
                          .handle(group);
                    },
                    selected: ref
                        .watch(muscleGroupFilterControllerProvider)
                        .contains(group),
                    padding: const EdgeInsets.only(right: AppLayout.p1),
                    name: group.name,
                    icon: Symbols.apps,
                    value: null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppLayout.p4),
            Text(
              'Movement Patterns',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.typography.headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppLayout.p2),
            Wrap(
              spacing: AppLayout.p2,
              runSpacing: AppLayout.p2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const RadioListItem(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: AppLayout.p1),
                  name: 'All',
                  icon: Symbols.apps,
                  value: null,
                ),
                ...MovementPattern.values.map(
                  (pattern) => RadioListItem(
                    onPressed: () {},
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(right: AppLayout.p1),
                    name: pattern.readableName,
                    icon: Symbols.apps,
                    value: pattern,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppLayout.p4),
            Text(
              'Equipment',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.typography.headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppLayout.p2),
            Wrap(
              spacing: AppLayout.p2,
              runSpacing: AppLayout.p2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const RadioListItem(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: AppLayout.p1),
                  name: 'All',
                  icon: Symbols.apps,
                  value: null,
                ),
                ...Equipment.values.map(
                  (equipment) => RadioListItem(
                    onPressed: () {},
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(right: AppLayout.p1),
                    name: equipment.readableName,
                    icon: Symbols.apps,
                    value: equipment,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppLayout.bottomBuffer),
          ],
        ),
      ),
    );
  }
}
